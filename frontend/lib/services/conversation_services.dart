import 'dart:convert';

import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/graphql/conversation/queries.dart';
import 'package:frontend/models/conversation_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ConversationServices {
  static Future<Conversations> conversations({
    String? name,
    required int page,
  }) async {
    try {
      final result = await graphqlClient!.value.query(
        QueryOptions<Conversations>(
          document: gql(getConversations),
          fetchPolicy: FetchPolicy.networkOnly,
          pollInterval: const Duration(seconds: 5),
          parserFn: (data) => Conversations.fromJson(
              data['conversations'] as Map<String, dynamic>),
          variables: {
            'name': name,
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
    throw Exception('Failed to get user conversations');
  }
}
