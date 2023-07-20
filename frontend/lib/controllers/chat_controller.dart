import 'dart:async';
import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:frontend/graphql/message/subscriptions.dart';
import 'package:frontend/models/conversation_model.dart';
import 'package:frontend/services/message_services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../core/imports/core_imports.dart';
import '../models/message_model.dart';

class ChatController extends GetxController {
  final Rx<Conversation> conversation = Conversation().obs;
  ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final pagingController = PagingController<int, Message>(
    firstPageKey: 1,
  );
  final RxBool hasScrolledUp = false.obs;
  final messageInput = ''.obs;
  late StreamSubscription<QueryResult<Message>> subscription;

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) async {
      if (conversation.value.id != null) {
        await fetchMessages(page);
      }
    });
    listenMessages();
    scrollController = ScrollController()..addListener(scrollListener);

    super.onInit();
  }

  void scrollListener() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients &&
          scrollController.offset > 600 &&
          hasScrolledUp.value == false) {
        hasScrolledUp.value = true;
      } else if (hasScrolledUp.value == true &&
          scrollController.hasClients &&
          scrollController.offset < 1) {
        hasScrolledUp.value = false;
      }
    });
  }

  Future<void> fetchMessages(int pageKey) async {
    try {
      final Messages newPage = await MessageServices.messages(
        id: conversation.value.id!,
        page: pageKey,
        text: null,
      );
      final newItems = newPage.messages;

      if (!newPage.hasNextPage! && newPage.nextPage == newPage.page) {
        pagingController.appendLastPage(newItems!);
      } else if (pagingController.nextPageKey != newPage.nextPage) {
        pagingController.appendPage(newItems!, newPage.nextPage);
      }
    } catch (e) {
      log(e.toString());
      pagingController.error = e;
    }
  }

  void listenMessages() {
    subscription = graphqlClient!.value
        .subscribe(
      SubscriptionOptions(
        document: gql(newMessage),
        variables: const {
          'id': "64b411079b61182c505e1da2",
        },
        parserFn: (data) => Message.fromJson(
          data['newMessage'] as Map<String, dynamic>,
        ),
      ),
    )
        .listen(
      (result) {
        if (result.hasException) {
          logError(result.exception.toString());
          return;
        } else {
          pagingController.itemList!.insert(0, result.parsedData!);
          pagingController
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              .notifyListeners();
        }
      },
    );
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    messageController.dispose();
    pagingController.dispose();
    subscription.cancel();
    super.onClose();
  }
}
