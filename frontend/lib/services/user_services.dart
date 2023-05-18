import 'package:frontend/config/graphql.dart';
import 'package:frontend/graphql/user/mutations.dart';
import 'package:frontend/utils/logging.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserServices {
  static Future<void> updateUserLocation({
    required String address,
    required List<double> coordinates,
  }) async {
    try {
      await graphqlClient!.value.mutate(
        MutationOptions(
          document: gql(updateLocation),
        ),
      );
    } catch (e) {
      logError(e.toString());
    }
  }
}
