import 'dart:convert';

import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/graphql/message/queries.dart';
import 'package:frontend/models/message_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MessageServices {
  static Future<Messages> messages({
    required String id,
    String? text,
    required int page,
  }) async {
    try {
      final result = await graphqlClient!.value.query(
        QueryOptions<Messages>(
          document: gql(getMessages),
          fetchPolicy: FetchPolicy.networkOnly,
          parserFn: (data) =>
              Messages.fromJson(data['messages'] as Map<String, dynamic>),
          variables: {
            'id': id,
            'text': text,
            'page': page,
            'limit': 20,
          },
        ),
      );
      logSuccess(json.encode(result.data));
      return result.parsedData!;
    } catch (e) {
      logError(e.toString());
    }
    throw Exception('Failed to get messages');
  }
}
