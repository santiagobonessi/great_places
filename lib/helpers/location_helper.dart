import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/env.dart';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude, double longitude}) {
    try {
      final googleStaticMapsUrl =
          'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${Env.GOOGLE_MAPS_API_KEY}';
      return googleStaticMapsUrl;
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future<String> getPlaceAddress(double latitude, double longitude) async {
    try {
      final googleGeocodeMapsUrl =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${Env.GOOGLE_MAPS_API_KEY}';
      final response = await http.get(Uri.parse(googleGeocodeMapsUrl));
      final jsonResponse = json.decode(response.body)['results'][0]['formatted_address'];
      return jsonResponse;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
