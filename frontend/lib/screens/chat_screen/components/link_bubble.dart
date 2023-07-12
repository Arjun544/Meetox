// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

import '../../../core/imports/core_imports.dart';
import '../../../core/imports/packages_imports.dart';

class LinkPreviewBubble extends StatelessWidget {
  final String link;

  const LinkPreviewBubble({super.key, required this.link});

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  // void getData() async {
  //   previewData.value = await getPreviewData(widget.link);
  //   isLoading.value = false;
  // }

  @override
  Widget build(BuildContext context) {
    final Rx<PreviewData> previewData = const PreviewData().obs;
    final RxBool isLoading = true.obs;

    void getData() async {
      previewData.value = await getPreviewData(link);
      isLoading.value = false;
    }

    getData();
    return Obx(
      () => isLoading.value
          ? Row(
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 20.sp,
                ),
                const SizedBox(width: 20),
                const Text('Loading link preview'),
              ],
            )
          : LinkPreview(
              enableAnimation: true,
              onPreviewDataFetched: (data) => previewData.value = data,
              previewData: previewData.value,
              text: link,
              width: Get.width,
              openOnPreviewImageTap: true,
              openOnPreviewTitleTap: true,
              textWidget: const SizedBox.shrink(),
              padding: EdgeInsets.zero,
              metadataTitleStyle: context.theme.textTheme.labelSmall!,
              metadataTextStyle: context.theme.textTheme.labelSmall!.copyWith(
                color: Colors.black38,
              ),
            ),
    );
  }
}
