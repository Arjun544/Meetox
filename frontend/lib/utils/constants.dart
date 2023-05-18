import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';

double headingLargeFontSize = 24.sp;
double headingOneFontSize = 20.sp;
double headingTwoFontSize = 18.sp;
double headingThreeFontSize = 16.sp;
double headingFourFontSize = 14.sp;
double headingFiveFontSize = 13.sp;
double headingSixFontSize = 11.sp;

EdgeInsets globalHorizentalPadding = EdgeInsets.symmetric(horizontal: 15.sp);

const String profilePlaceHolder =
    'https://static.vecteezy.com/system/resources/previews/003/337/584/original/default-avatar-photo-placeholder-profile-icon-vector.jpg';

// MapBox
final String mapBoxAccessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
final String lightMapUrl = dotenv.env['LIGHT_MAP_URL']!;
final String darkMapUrl = dotenv.env['DARK_MAP_URL']!;
final String skyMapUrl = dotenv.env['SKY_MAP_URL']!;
final String meetoxMapUrl = dotenv.env['MEETOX_MAP_URL']!;
