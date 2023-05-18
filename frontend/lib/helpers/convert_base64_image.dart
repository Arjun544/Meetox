import 'dart:convert';
import 'dart:io';

String convertIntoBase64Image(String path) {
  final bytes = File(path).readAsBytesSync();
  final base64Profile = 'data:image/png;base64,${base64Encode(bytes)}';
  return base64Profile;
}
