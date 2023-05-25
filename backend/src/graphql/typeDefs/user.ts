import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar IUser
  scalar ILocation

  type Query {
    getUser: IUser
  }
  type Query {
    getNearByUsers(
      latitude: Float!
      longitude: Float!
      distanceInKM: Float!
      followers: [String!]!
    ): [IUser]
  }

  type Mutation {
    addProfile(name: String!, birthDate: String!, profile: String!): IUser
  }

  type Mutation {
    updateLocation(location: LocationInput!): Boolean
  }

  type Subscription {
    locationUpdated: ILocation!
  }

  input LocationInput {
    address: String
    coordinates: [Float]
  }
  type LocationResponse {
    address: String
    coordinates: [Float]
  }
`;

export default typeDefs;
