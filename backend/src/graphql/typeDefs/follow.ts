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
    nearByFollowers(
      latitude: Float!
      longitude: Float!
      distanceInKM: Float!
    ): [NearByFollowerResponse]
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

  type NearByFollowerResponse {
    id: String
    name: String
    display_pic: IImage
    isPremium: Boolean
    location: ILocation
    createdAt: Date
    updatedAt: Date
    followers: Int
    followings: Int
  }
`;

export default typeDefs;
