
import 'package:frontend/controllers/feeds_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/widgets/top_bar.dart';

class FeedScreen extends GetView<FeedsController> {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
            isPrecise: false.obs,
          ),
          
        ],
      ),
    );
  }
}
