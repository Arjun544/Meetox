import 'package:jwt_decoder/jwt_decoder.dart';

Map<String, dynamic> decodeToken(String token) {
  final decodedToken = JwtDecoder.decode(token);
  final hasExpired = JwtDecoder.isExpired(token);

  return {'id': decodedToken['id'], 'hasExpired': hasExpired};
}
