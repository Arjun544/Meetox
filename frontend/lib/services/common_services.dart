import 'package:dio/dio.dart';
import 'package:frontend/utils/logging.dart';

final Dio dio = Dio();

class CommonServices {
  static Future<Map<String, dynamic>> getAddress() async {
    try {
      final response = await dio.get('http://ip-api.com/json');
      if (response.data['status'] == 'success') {
        return {
          'country': response.data['country'],
          'region': response.data['regionName'],
        };
      }
    } catch (e) {
      logError(e.toString());
      
    }
    throw Exception('Failed to get address');
  }

  // static Future<File> getFileImage(String path) async {
  //   final response = await dio.get<List<int>>(
  //     path,
  //     options: Options(responseType: ResponseType.bytes),
  //   );
  //   var uint8list = Uint8List.fromList(response.data!);
  //   var buffer = uint8list.buffer;
  //   var byteData = ByteData.view(buffer);
  //   var tempDir = await getTemporaryDirectory();
  //   var file = await File('${tempDir.path}/img').writeAsBytes(
  //       buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //   return file;
  // }
}
