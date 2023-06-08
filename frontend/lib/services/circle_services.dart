import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/graphql/circle/queries.dart';
import 'package:frontend/models/circle_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CircleServices {
  static Future<UserCircles> userCircles({
    required int page,
  }) async {
    try {
      final result = await graphqlClient!.value.query(
        QueryOptions<UserCircles>(
          document: gql(getUserCircles),
          fetchPolicy: FetchPolicy.networkOnly,
          parserFn: (data) =>
              UserCircles.fromJson(data['userCircles'] as Map<String, dynamic>),
          variables: {
            'page': page,
            'limit': 20,
          },
        ),
      );

      return result.parsedData!;
    } catch (e) {
      logError(e.toString());
    }
    throw Exception('Failed to get user circles');
  }
}
