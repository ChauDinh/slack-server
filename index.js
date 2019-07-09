import express from "express";
import bodyParser from "body-parser";
import { graphqlExpress, graphiqlExpress } from "apollo-server-express";
import { makeExecutableSchema } from "graphql-tools";

import typeDefs from "./schema";
import resolvers from "./resolvers";
import models from "./models";

const schema = makeExecutableSchema({
  typeDefs,
  resolvers
});

const app = express();

const grapqlEnpoint = "/graphql";

app.use(grapqlEnpoint, bodyParser.json(), graphqlExpress({ schema }));
app.use("/graphiql", graphiqlExpress({ endpointURL: grapqlEnpoint }));

models.sequelize.sync({ force: true }).then(() => {
  app.listen(8080);
});
