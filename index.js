import express from "express";
import path from "path";
import bodyParser from "body-parser";
import { graphqlExpress, graphiqlExpress } from "apollo-server-express";
import { makeExecutableSchema } from "graphql-tools";
import { fileLoader, mergeTypes, mergeResolvers } from "merge-graphql-schemas";
import cors from "cors";

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
      },
      SECRET,
      SECRET2
    }
  })
);
app.use("/graphiql", graphiqlExpress({ endpointURL: grapqlEnpoint }));

models.sequelize.sync({}).then(() => {
  app.listen(8080);
});
