import express from "express";
import path from "path";
import bodyParser from "body-parser";
import { graphqlExpress, graphiqlExpress } from "apollo-server-express";
import { makeExecutableSchema } from "graphql-tools";
import { fileLoader, mergeTypes, mergeResolvers } from "merge-graphql-schemas";
import cors from "cors";
import jwt from "jsonwebtoken";

import { refreshTokens } from "./auth";

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

app.use(addUser);

const grapqlEnpoint = "/graphql";

app.use(
  grapqlEnpoint,
  bodyParser.json(),
  graphqlExpress(req => ({
    schema,
    context: {
      models,
      user: req.user,
      SECRET,
      SECRET2
    }
  }))
);
app.use("/graphiql", graphiqlExpress({ endpointURL: grapqlEnpoint }));

models.sequelize.sync({}).then(() => {
  app.listen(8080);
});
