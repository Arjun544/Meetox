import gql from "graphql-tag";
import { IUser } from "../../utils/interfaces/user";

const typeDefs = gql`
  scalar Date
  scalar IUser

  type Mutation {
    loginWithGmail(email: String!, address: AddressInput!): AuthPayLoad
  }

  type Query {
    login: IUser
  }

  input AddressInput {
    country: String
    region: String
  }

  type AuthPayLoad {
    token: String
    user: IUser
  }
`;

export default typeDefs;
