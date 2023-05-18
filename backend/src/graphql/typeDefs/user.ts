import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IUser

  type Query {
    getUser: IUser
  }

  type Mutation {
    addProfile(name: String!, birthDate: String!, profile: String!): IUser
  }
`;

export default typeDefs;
