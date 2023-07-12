import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:frontend/models/conversation_model.dart';
import 'package:frontend/services/message_services.dart';
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

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) async {
      if (conversation.value.id != null) {
        await fetchMessages(page);
      }
    });
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

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    messageController.dispose();
    pagingController.dispose();
    super.onClose();
  }
}
