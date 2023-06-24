import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';

IconData getSocial(String social) {
  switch (social) {
    case 'instagram':
    return  FlutterRemix.instagram_fill;
    case 'facebook':
     return FlutterRemix.facebook_fill;
    case 'whatsapp':
    return  FlutterRemix.whatsapp_fill;
    default:
      return FlutterRemix.whatsapp_fill;
  }
}
