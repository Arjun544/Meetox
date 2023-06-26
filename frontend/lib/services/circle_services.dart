import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/graphql/circle/queries.dart';
import 'package:frontend/models/circle_model.dart';
import 'package:frontend/models/member_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CircleServices {
  static Future<UserCircles> userCircles({
    String? name,
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
            'name': name,
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

  static Future<Members> circleMembers({
    String? name,
    required String id,
    required int page,
  }) async {
    try {
      final result = await graphqlClient!.value.query(
        QueryOptions<Members>(
          document: gql(members),
          fetchPolicy: FetchPolicy.networkOnly,
          parserFn: (data) =>
              Members.fromJson(data['members'] as Map<String, dynamic>),
          variables: {
            'id': id,
            'name': name,
            'page': page,
            'limit': 20,
          },
        ),
      );
      return result.parsedData!;
    } catch (e) {
      logError(e.toString());
    }
    throw Exception('Failed to get circle members');
  }
}
