"use strict";

var _express = require("express");

var _express2 = _interopRequireDefault(_express);

var _path = require("path");

var _path2 = _interopRequireDefault(_path);

var _bodyParser = require("body-parser");

var _bodyParser2 = _interopRequireDefault(_bodyParser);

var _apolloServerExpress = require("apollo-server-express");

var _graphqlTools = require("graphql-tools");

var _http = require("http");

var _graphql = require("graphql");

var _subscriptionsTransportWs = require("subscriptions-transport-ws");

var _mergeGraphqlSchemas = require("merge-graphql-schemas");

var _cors = require("cors");

var _cors2 = _interopRequireDefault(_cors);

var _jsonwebtoken = require("jsonwebtoken");

var _jsonwebtoken2 = _interopRequireDefault(_jsonwebtoken);

var _formidable = require("formidable");

var _formidable2 = _interopRequireDefault(_formidable);

var _dataloader = require("dataloader");

var _dataloader2 = _interopRequireDefault(_dataloader);

var _auth = require("./auth");

var _batchFunctions = require("./batchFunctions");

var _models = require("./models");

var _models2 = _interopRequireDefault(_models);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

// eslint-disable-next-line no-undef
const SECRET = `${process.env.SECRET || "kimboyune2k"}`;
// eslint-disable-next-line no-undef
const SECRET2 = `${process.env.SECRET2 || "kimboyunelovechau"}`;

// eslint-disable-next-line no-undef
const typeDefs = (0, _mergeGraphqlSchemas.mergeTypes)((0, _mergeGraphqlSchemas.fileLoader)(_path2.default.join(__dirname, "./schema")));

const resolvers = (0, _mergeGraphqlSchemas.mergeResolvers)(
// eslint-disable-next-line no-undef
(0, _mergeGraphqlSchemas.fileLoader)(_path2.default.join(__dirname, "./resolvers")));

const schema = (0, _graphqlTools.makeExecutableSchema)({
	typeDefs,
	resolvers
});

const app = (0, _express2.default)();

// Allowing requests from other sites access this server
app.use((0, _cors2.default)("*"));

const uploadDir = "files";

const fileMiddleware = (req, res, next) => {
	if (!req.is("multipart/form-data")) {
		return next();
	}

	const form = _formidable2.default.IncomingForm({
		uploadDir
	});

	form.parse(req, (error, { operations }, files) => {
		if (error) {
			console.log(error);
		}

		const document = JSON.parse(operations);

		if (Object.keys(files).length) {
			const {
				file: { type, path: filePath }
			} = files;
			console.log(type);
			console.log(filePath);
			document.variables.file = {
				type,
				path: filePath
			};
		}

		req.body = document;
		next();
	});
};

const grapqlEnpoint = "/graphql";

app.use("/files", _express2.default.static("files"));

const server = (0, _http.createServer)(app);

(0, _models2.default)().then(models => {
	if (!models) {
		console.error("Couldn't connect to database!");
		return;
	}
	const addUser = async (req, res, next) => {
		const token = req.headers["x-token"];
		if (token) {
			try {
				const { user } = _jsonwebtoken2.default.verify(token, SECRET);
				req.user = user;
			} catch (err) {
				const refreshToken = req.headers["x-refresh-token"];
				const newTokens = await (0, _auth.refreshTokens)(token, refreshToken, models, SECRET, SECRET2);

				if (newTokens.token && newTokens.refreshToken) {
					res.set("Access-Control-Expose-Headers", "x-token, x-refresh-token");
					res.set("x-token", newTokens.token);
					res.set("x-refresh-token", newTokens.refreshToken);
				}

				req.user = newTokens.user;
			}
		}
		next();
	};

	app.use(addUser);

	app.use(grapqlEnpoint, _bodyParser2.default.json(), fileMiddleware, (0, _apolloServerExpress.graphqlExpress)(req => ({
		schema,
		context: {
			models,
			user: req.user,
			SECRET,
			SECRET2,
			channelLoader: new _dataloader2.default(ids => (0, _batchFunctions.channelBatch)(ids, models, req.user)),
			userLoader: new _dataloader2.default(ids => (0, _batchFunctions.userBatch)(ids, models)),
			serverUrl: `${req.protocol} + "://" + ${req.get("host")}`
		}
	})));
	app.use("/graphiql", (0, _apolloServerExpress.graphiqlExpress)({
		endpointURL: grapqlEnpoint,
		subscriptionsEndpoint: `ws://localhost:8080/subscriptions`
	}));

	models.sequelize.sync().then(() => {
		server.listen(8080, () => {
			new _subscriptionsTransportWs.SubscriptionServer({
				subscribe: _graphql.subscribe,
				schema,
				// eslint-disable-next-line no-unused-vars
				onConnect: async ({ token, refreshToken }, webSocket) => {
					if (token && refreshToken) {
						try {
							const {
								user
							} = _jsonwebtoken2.default.verify(token, SECRET);

							return {
								models,
								user
							};
						} catch (err) {
							const newTokens = await (0, _auth.refreshTokens)(token, refreshToken, models, SECRET, SECRET2);

							return {
								models,
								user: newTokens.user
							};
						}
					}
					return { models };
				},
				// eslint-disable-next-line no-unused-vars
				onDisconnect: async webSocket => {
					return { models };
				},
				execute: _graphql.execute
			}, {
				server,
				path: "/subscriptions"
			});
		});
	});
});