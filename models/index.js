import Sequelize from "sequelize";

const sequelize = new Sequelize("slack", "chaudinh", "katetsui1995", {
  dialect: "postgres"
});

const models = {
  User: sequelize.import("./user"),
  Channel: sequelize.import("./channel"),
  Team: sequelize.import("./team"),
  Message: sequelize.import("./message")
};

Object.keys(models).forEach(modelName => {
  if ("associate" in models[modelName]) {
    models[modelName].associate(models);
  }
});

models.sequelize = sequelize;
models.Sequelize = Sequelize;

export default models;
