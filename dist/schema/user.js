"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
// CRUD - create, read, update and delete

exports.default = "\ntype User {\n  id: Int!\n  email: String!\n  username: String!\n  teams: [Team!]!\n}\n\ntype Query {\n  me: User!\n  allUsers: [User!]!\n  getUser(userId: Int!): User\n}\n\ntype RegisterResponse {\n  ok: Boolean!\n  user: User\n  errors: [Error!]\n}\n\ntype LoginResponse {\n  ok: Boolean!\n  token: String\n  refreshToken: String\n  errors: [Error!]\n}\n\ntype Mutation {\n  register(username: String!, email: String!, password: String!): RegisterResponse!\n  login(email: String!, password: String!): LoginResponse!\n}\n";