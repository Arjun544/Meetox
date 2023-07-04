import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IUser
  scalar ILocation
  scalar IImage
  scalar ISocialLink

  type Query {
    getUser(id: String): UserResponse
    getNearByUsers(
      latitude: Float!
      longitude: Float!
      distanceInKM: Float!
    ): [NearByUserResponse]
    socials(id: String!): [ISocialLink]
  }

  type Mutation {
    addProfile(name: String!, birthDate: String!, profile: String!): IUser
    updateLocation(location: LocationInput!): Boolean
  }

  input LocationInput {
    address: String
    coordinates: [Float]
  }

  type UserResponse {
    id: String
    email: String
    name: String
    display_pic: IImage
    isPremium: Boolean
    location: ILocation
    createdAt: Date
    updatedAt: Date
  }

  type NearByUserResponse {
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
