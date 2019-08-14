"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

exports.default = sequelize => {
  const PrivateMembers = sequelize.define("private_member", {});

  return PrivateMembers;
};