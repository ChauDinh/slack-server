"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = "\ntype Channel {\n  id: Int!\n  name: String!\n  messages: [Message!]!\n  public: Boolean!\n  users: [User!]!\n  dm: Boolean!\n}\n\ntype ChannelResponse {\n  ok: Boolean!\n  channel: Channel\n  errors: [Error!]\n}\n\ntype DMChannelResponse {\n  id: Int!\n  name: String!\n}\n\ntype Mutation {\n  createChannel(teamId: Int!, name: String!, public: Boolean=false, members: [Int!]=[]): ChannelResponse!\n  getOrCreateChannel(teamId: Int!, members: [Int!]!): DMChannelResponse!\n}\n";