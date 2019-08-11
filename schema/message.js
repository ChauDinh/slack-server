export default `
type Message {
  id: Int!
  text: String
  user: User!
  channel: Channel!
  created_at: String!
  url: String
  filetype: String
}

input File {
  type: String!
  path: String!
}

type Query {
  messages(channelId: Int!, cursor: String): [Message!]!
}

type Subscription {
  newChannelMessage(channelId: Int!): Message!
}

type Mutation {
  createMessage(channelId: Int!, text: String, file: File): Boolean!
}

`;
