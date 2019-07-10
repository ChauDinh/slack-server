// CRUD - create, read, update and delete

export default `
type User {
  id: Int!
  email: String!
  username: String!
  teams: [Team!]!
}

type Query {
  getUser(id: Int!): User!
  allUsers: [User!]!
}

type Mutation {
  createUser(username: String!, email: String!, password: String!): User!
}
`;
