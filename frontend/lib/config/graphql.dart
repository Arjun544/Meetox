import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/services/secure_storage_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient>? graphqlClient;

Future<void> graphqlInit() async {
  await initHiveForFlutter();

  final httpLink = HttpLink(
    // 'http://192.168.1.181:4000/graphql',
    'http://192.168.43.29:4000/graphql',
  );
  final token = await SecureStorageServices.readValue(key: 'accessToken');

    logSuccess('token $token');
  if (token != null) {

    final authLink = AuthLink(
      getToken: () async => 'Bearer $token',
    );
    var link = authLink.concat(httpLink);

    final websocketLink = WebSocketLink(
      // 'ws://192.168.1.181:4000/graphql/subscriptions',
      'ws://192.168.43.29:4000/graphql/subscriptions',
      config: SocketClientConfig(
        initialPayload: {
          'token': token,
        },
      ),
      subProtocol: GraphQLProtocol.graphqlTransportWs,
    );

    link = Link.split((request) => request.isSubscription, websocketLink, link);

    graphqlClient = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: HiveStore(),
        ),
      ),
    );
  } else {
    final Link link = httpLink;
    graphqlClient = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
}
