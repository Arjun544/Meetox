import 'package:geolocator/geolocator.dart';

double getDistance(double x1, double y1, double x2, double y2) {
  return Geolocator.distanceBetween(
        x1,
        y1,
        x2,
        y2,
      ) *
      0.001;
}
