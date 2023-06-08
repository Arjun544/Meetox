import 'package:frontend/core/imports/core_imports.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    // final locationSubscription = graphqlClient!.value.subscribe(
    //   SubscriptionOptions(
    //     document: gql(locationUpdated),
    //     // parserFn: (data) {
    //     //   return User.fromJson(data);
    //     // },
    //   ),
    // )..listen((result) {
    //     if (result.hasException) {
    //       logError(result.exception.toString());
    //       return;
    //     } else {
    //       logError('Location subscription');

    //       currentUser.value.location = Location.fromJson(
    //         result.data!['locationUpdated'] as Map<String, dynamic>,
    //       );
    //       currentUser.refresh();
    //     }
    //   });

    super.onInit();
  }
}
