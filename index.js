import express from "express";
import path from "path";
import bodyParser from "body-parser";
import { graphqlExpress, graphiqlExpress } from "apollo-server-express";
import { makeExecutableSchema } from "graphql-tools";
import { createServer } from "http";
import { execute, subscribe } from "graphql";
import { SubscriptionServer } from "subscriptions-transport-ws";
import { fileLoader, mergeTypes, mergeResolvers } from "merge-graphql-schemas";
import cors from "cors";
import jwt from "jsonwebtoken";
import formidable from "formidable";
import DataLoader from "dataloader";

import { refreshTokens } from "./auth";
import { channelBatch } from "./batchFunctions";

import models from "./models";

const SECRET = "kimboyune2k";
const SECRET2 = "kimboyunelovechau";

// eslint-disable-next-line no-undef
const typeDefs = mergeTypes(fileLoader(path.join(__dirname, "./schema")));

const resolvers = mergeResolvers(
  // eslint-disable-next-line no-undef
  fileLoader(path.join(__dirname, "./resolvers"))
);

const schema = makeExecutableSchema({
  typeDefs,
  resolvers
});

const app = express();

// Allowing requests from other sites access this server
app.use(cors("*"));

const addUser = async (req, res, next) => {
  const token = req.headers["x-token"];
  if (token) {
    try {
      const { user } = jwt.verify(token, SECRET);
      req.user = user;
    } catch (err) {
      const refreshToken = req.headers["x-refresh-token"];
      const newTokens = await refreshTokens(
        token,
        refreshToken,
        models,
        SECRET,
        SECRET2
      );

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

const uploadDir = "files";

const fileMiddleware = (req, res, next) => {
  if (!req.is("multipart/form-data")) {
    return next();
  }

  const form = formidable.IncomingForm({
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

app.use(addUser);

const grapqlEnpoint = "/graphql";

app.use(
  grapqlEnpoint,
  bodyParser.json(),
  fileMiddleware,
  graphqlExpress(req => ({
    schema,
    context: {
      models,
      user: req.user,
      SECRET,
      SECRET2,
      channelLoader: new DataLoader(ids => channelBatch(ids, models, req.user))
    }
  }))
);
app.use(
  "/graphiql",
  graphiqlExpress({
    endpointURL: grapqlEnpoint,
    subscriptionsEndpoint: `ws://localhost:8080/subscriptions`
  })
);

app.use("/files", express.static("files"));

const server = createServer(app);

models.sequelize.sync({}).then(() => {
  server.listen(8080, () => {
    new SubscriptionServer(
      {
        execute,
        subscribe,
        schema,
        // eslint-disable-next-line no-unused-vars
        onConnect: async ({ token, refreshToken }, webSocket) => {
          if (token && refreshToken) {
            try {
              const { user } = jwt.verify(token, SECRET);
              return { models, user };
            } catch (err) {
              const newTokens = await refreshTokens(
                token,
                refreshToken,
                models,
                SECRET,
                SECRET2
              );
              return { models, user: newTokens.user };
            }
            // const member = await models.Member.findOne({
            //   where: { teamId: 1, userId: user.id }
            // });
            // if (!member) {
            //   throw new Error("Missing auth token!");
            // }
          }

          return { models };
        }
      },
      {
        server,
        path: "/subscriptions"
      }
    );
  });
});
