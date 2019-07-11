import express from "express";
import path from "path";
import bodyParser from "body-parser";
import { graphqlExpress, graphiqlExpress } from "apollo-server-express";
import { makeExecutableSchema } from "graphql-tools";
import { fileLoader, mergeTypes, mergeResolvers } from "merge-graphql-schemas";
import cors from "cors";

import models from "./models";

const typeDefs = mergeTypes(fileLoader(path.join(__dirname, "./schema")));

const resolvers = mergeResolvers(
  fileLoader(path.join(__dirname, "./resolvers"))
);

const schema = makeExecutableSchema({
  typeDefs,
  resolvers
});

const app = express();

// Allowing requests from other sites access this server
app.use(cors("*"));

const grapqlEnpoint = "/graphql";

app.use(
  grapqlEnpoint,
  bodyParser.json(),
  graphqlExpress({
    schema,
    context: {
      models,
      user: {
        id: 1
      }
    }
  })
);
app.use("/graphiql", graphiqlExpress({ endpointURL: grapqlEnpoint }));

models.sequelize.sync({}).then(() => {
  app.listen(8080);
});
