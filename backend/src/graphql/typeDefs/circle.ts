import gql from "graphql-tag";

const typeDefs = gql`
  scalar Date
  scalar ICircle
  scalar ILocation

  #   type Query {
  #     getUser: IUser
  #   }

  type Mutation {
    addCircle(
      name: String!
      description: String!
      isPrivate: Boolean!
      limit: Int
      image: String!
      members: [String]!
      location: ILocation
    ): ICircle
  }
`;

export default typeDefs;
