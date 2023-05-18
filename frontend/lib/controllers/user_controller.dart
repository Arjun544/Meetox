import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/graphql/user/subscriptions.dart';
import 'package:frontend/models/user_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    final userSubscription = graphqlClient!.value.subscribe(
      SubscriptionOptions(
        document: gql(userUpdated),
        parserFn: (data) {
          return User.fromJson(data);
        },
      ),
    )..listen((result) {
        if (result.hasException) {
          logError(result.exception.toString());
          return;
        } else {
          logSuccess('user subscription: ${result.data}');
          currentUser.value = result.parsedData!;
          currentUser.refresh();
        }
      });

    super.onInit();
  }
}
