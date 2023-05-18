import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/graphql/user/subscriptions.dart';
import 'package:frontend/models/user_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    final locationSubscription = graphqlClient!.value.subscribe(
      SubscriptionOptions(
        document: gql(locationUpdated),
        // parserFn: (data) {
        //   return User.fromJson(data);
        // },
      ),
    )..listen((result) {
        if (result.hasException) {
          logError(result.exception.toString());
          return;
        } else {
          logSuccess('location subscription: ${result.data}');
          // currentUser.value.location = result.data!;
          // currentUser.refresh();
        }
      });

    super.onInit();
  }
}
