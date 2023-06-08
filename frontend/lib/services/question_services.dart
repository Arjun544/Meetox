import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/graphql/question/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/question_model.dart';

class QuestionServices {
  static Future<UserQuestions> userQuestions({
    String? name,
    required int page,
  }) async {
    try {
      final result = await graphqlClient!.value.query(
        QueryOptions<UserQuestions>(
          document: gql(getUserQuestions),
          fetchPolicy: FetchPolicy.networkOnly,
          parserFn: (data) => UserQuestions.fromJson(
              data['userQuestions'] as Map<String, dynamic>),
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
    throw Exception('Failed to get user questions');
  }
}
