
import 'package:frontend/core/imports/core_imports.dart';

void moveCursorToEnd(TextEditingController controller) {
  controller.selection = TextSelection.fromPosition(
    TextPosition(offset: controller.text.length),
  );
}
