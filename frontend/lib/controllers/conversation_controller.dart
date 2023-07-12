import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/models/conversation_model.dart';
import 'package:frontend/services/conversation_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ConversationController extends GetxController {
  final conversationsPagingController =
      PagingController<int, Conversation>(firstPageKey: 1);

  final RxString searchQuery = ''.obs;
  late Worker searchDebounce;

  @override
  void onInit() {
    super.onInit();
    conversationsPagingController.addPageRequestListener((page) async {
      await fetchConversations(page);
      searchDebounce = debounce(
        searchQuery,
        (value) {
          conversationsPagingController.refresh();
        },
        time: const Duration(seconds: 2),
      );
    });
  }

  Future<void> fetchConversations(int pageKey) async {
    try {
      final newPage = await ConversationServices.conversations(
        page: pageKey,
        name: searchQuery.value.isEmpty ? null : searchQuery.value,
      );

      final newItems = newPage.conversations;

      if (newPage.nextPage == null &&
          !newPage.hasNextPage! &&
          newPage.nextPage == newPage.page) {
        conversationsPagingController.appendLastPage(newItems!);
      } else if (conversationsPagingController.nextPageKey !=
          newPage.nextPage) {
        conversationsPagingController.appendPage(newItems!, newPage.nextPage);
      }
    } catch (e) {
      logError(e.toString());
      conversationsPagingController.error = e;
    }
  }
}
