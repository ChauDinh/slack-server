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
import { channelBatch, userBatch } from "./batchFunctions";

import getModels from "./models";

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

const grapqlEnpoint = "/graphql";

app.use("/files", express.static("files"));

const server = createServer(app);

getModels().then(models => {
  if (!models) {
    console.error("Couldn't connect to database!");
    return;
  }
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

  app.use(addUser);

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
        onlineUsers,
        channelLoader: new DataLoader(ids =>
          channelBatch(ids, models, req.user)
        ),
        userLoader: new DataLoader(ids => userBatch(ids, models)),
        serverUrl: `${req.protocol} + "://" + ${req.get("host")}`
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

  let onlineUsers = [];

  models.sequelize.sync({ force: true }).then(() => {
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
                const userIdx = onlineUsers.findIndex(
                  obj => obj.username === user.username
                );
                if (userIdx < 0) {
                  onlineUsers.push({
                    username: user.username,
                    last_seen: Date.now()
                  });
                } else {
                  onlineUsers[userIdx].last_seen = Date.now();
                }
                console.log(onlineUsers);
                return { models, user, onlineUsers };
              } catch (err) {
                const newTokens = await refreshTokens(
                  token,
                  refreshToken,
                  models,
                  SECRET,
                  SECRET2
                );

                return { models, user: newTokens.user, onlineUsers };
              }
            }
            return { models, onlineUsers };
          },
          // eslint-disable-next-line no-unused-vars
          onDisconnect: async webSocket => {
            // console.log("some one disconnect");
            // console.log(onlineUsers);
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
});
