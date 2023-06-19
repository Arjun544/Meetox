import 'dart:convert';

import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/graphql/user/queries.dart';
import 'package:frontend/models/follower_model.dart';
import 'package:frontend/models/following_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FollowServices {
  static Future<Followers> userFollowers({
    String? name,
    required String id,
    required int page,
  }) async {
    try {
      final result = await graphqlClient!.value.query(
        QueryOptions<Followers>(
          document: gql(getUserFollowers),
          fetchPolicy: FetchPolicy.networkOnly,
          parserFn: (data) =>
              Followers.fromJson(data['followers'] as Map<String, dynamic>),
          variables: {
            'id': id,
            'name': name,
            'page': page,
            'limit': 20,
          },
        ),
      );
      logError(json.encode(result.data));
      return result.parsedData!;
    } catch (e) {
      logError(e.toString());
    }
    throw Exception('Failed to get user followers');
  }

  static Future<Following> userFollowing({
    String? name,
    required String id,
    required int page,
  }) async {
    try {
      final result = await graphqlClient!.value.query(
        QueryOptions<Following>(
          document: gql(getUserFollowing),
          fetchPolicy: FetchPolicy.networkOnly,
          parserFn: (data) =>
              Following.fromJson(data['following'] as Map<String, dynamic>),
          variables: {
            'id': id,
            'name': name,
            'page': page,
            'limit': 20,
          },
        ),
      );
      logError(json.encode(result.data));
      return result.parsedData!;
    } catch (e) {
      logError(e.toString());
    }
    throw Exception('Failed to get user following');
  }
}
