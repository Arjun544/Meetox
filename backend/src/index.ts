import { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@apollo/server/express4";
import { ApolloServerPluginDrainHttpServer } from "@apollo/server/plugin/drainHttpServer";
import { makeExecutableSchema } from "@graphql-tools/schema";
import bodyParser, { json } from "body-parser";
import cors from "cors";
import * as dotenv from "dotenv";
import express from "express";
import { PubSub } from "graphql-subscriptions";
import { useServer } from "graphql-ws/lib/use/ws";
import { createServer } from "http";
import { WebSocketServer } from "ws";
import { connectToDatabase } from "./config/mongodb";
import resolvers from "./graphql/resolvers";
import typeDefs from "./graphql/typeDefs";
import { GraphQLContext, SubscriptionContext } from "./utils/types";

const main = async () => {
  dotenv.config();
  // Create the schema, which will be used separately by ApolloServer and
  // the WebSocket server.
  const schema = makeExecutableSchema({
    typeDefs,
    resolvers,
  });

  // Create an Express app and HTTP server; we will attach both the WebSocket
  // server and the ApolloServer to this HTTP server.
  const app = express();
  const httpServer = createServer(app);

  // Create our WebSocket server using the HTTP server we just set up.
  const wsServer = new WebSocketServer({
    server: httpServer,
    path: "/graphql/subscriptions",
  });

  // Context parameters
  const pubsub = new PubSub();

  const getSubscriptionContext = async (
    ctx: SubscriptionContext
  ): Promise<GraphQLContext> => {
    ctx;
    // ctx is the graphql-ws Context where connectionParams live
    if (ctx.connectionParams) {
      const { token } = ctx.connectionParams;

      const tokeData: string = token || "";

      return { req: null, token: tokeData, pubsub };
    }
    return { req: null, token: "", pubsub };
  };

  const serverCleanup = useServer(
    {
      schema,
      context: (ctx: SubscriptionContext) => {
        return getSubscriptionContext(ctx);
      },

      onConnect: (ctx) => {
        console.log("Socket connection established");
      },
      onDisconnect: (ctx) => {
        console.log("Socket disconnected");
      },
      onError(ctx, message, errors) {
        console.log("Socket error: " + message.payload);
      },
    },
    wsServer
  );
  // Set up ApolloServer.
  const server = new ApolloServer({
    schema,
    csrfPrevention: true,
    plugins: [
      // Proper shutdown for the HTTP server.
      ApolloServerPluginDrainHttpServer({ httpServer }),

      // Proper shutdown for the WebSocket server.
      {
        async serverWillStart() {
          return {
            async drainServer() {
              await serverCleanup.dispose();
            },
          };
        },
      },
    ],
  });
  await server.start();

  const corsOptions = {
    origin: "http://localhost:4000",
    credentials: true,
  };

  app.use(
    "/graphql",
    cors<cors.CorsRequest>(corsOptions),
    json({
      limit: "10mb",
    }),
    expressMiddleware(server, {
      context: async ({ req }): Promise<GraphQLContext> => {
        const header = req.headers.authorization;
        const token = header?.replace("Bearer ", "") as string;
        return { req, token, pubsub };
      },
    })
  );

  // server.mid({ app, path: "/graphql", cors: corsOptions });

  const PORT = 4000;

  await connectToDatabase();

  // Now that our HTTP server is fully set up, we can listen to it.
  await new Promise<void>((resolve) =>
    httpServer.listen({ port: PORT }, resolve)
  );
  console.log(`🚀 Server is now running on http://localhost:4000/graphql`);
};

main().catch((err) => console.log(err));
