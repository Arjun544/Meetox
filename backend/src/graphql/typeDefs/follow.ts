import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IFollow

  type Mutation {
    follow(id: String!): IFollow
    unFollow(id: String!): Boolean
  }

  type Query {
    isFollowed(id: String!): Boolean
  }
`;

export default typeDefs;
