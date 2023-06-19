import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IFollow
  scalar IUser

  type Mutation {
    follow(id: String!): IFollow
    unFollow(id: String!): Boolean
  }

  type Query {
    isFollowed(id: String!): Boolean
    followers(
      id: String!
      name: String
      page: Int!
      limit: Int!
    ): FollowersResponse
    following(
      id: String!
      name: String
      page: Int!
      limit: Int!
    ): FollowingsResponse
  }

  type FollowersResponse {
    page: Int
    nextPage: Int
    prevPage: Int
    hasNextPage: Boolean
    hasPrevPage: Boolean
    total_pages: Int
    total_results: Int
    followers: [IUser]
  }

  type FollowingsResponse {
    page: Int
    nextPage: Int
    prevPage: Int
    hasNextPage: Boolean
    hasPrevPage: Boolean
    total_pages: Int
    total_results: Int
    followings: [IUser]
  }
`;

export default typeDefs;
