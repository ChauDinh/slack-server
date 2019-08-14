"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _sequelize = require("sequelize");

var _sequelize2 = _interopRequireDefault(_sequelize);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const sequelize = new _sequelize2.default(
// eslint-disable-next-line no-undef
process.env.TEST_DB || "slack", "chaudinh", "katetsui1995", {
  dialect: "postgres",
  operatorAliases: _sequelize2.default.Op,
  define: {
    underscored: true
  }
});

const models = {
  User: sequelize.import("./user"),
  Channel: sequelize.import("./channel"),
  Team: sequelize.import("./team"),
  Message: sequelize.import("./message"),
  Member: sequelize.import("./member.js"),
  DirectMessage: sequelize.import("./directMessage.js"),
  PrivateMembers: sequelize.import("./privateMembers.js")
};

Object.keys(models).forEach(modelName => {
  if ("associate" in models[modelName]) {
    models[modelName].associate(models);
  }
});

models.sequelize = sequelize;
models.Sequelize = _sequelize2.default;
models.op = _sequelize2.default.Op;

exports.default = models;