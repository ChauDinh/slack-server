"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

exports.default = function (sequelize) {
  var PrivateMembers = sequelize.define("private_member", {});

  return PrivateMembers;
};