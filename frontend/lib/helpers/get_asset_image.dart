import 'dart:io';

import 'package:frontend/core/imports/core_imports.dart';

Future<File> getImageFileFromAssets(String path) async {
  final imageName =
      path.substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'));

  final systemTempDir = Directory.systemTemp;
  final byteData = await rootBundle.load(path);
  final file = File('${systemTempDir.path}/$imageName.png');

  final image = await file.writeAsBytes(
    byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
  );

  return image;
}
