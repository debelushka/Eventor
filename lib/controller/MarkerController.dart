import 'dart:convert';
import 'package:eventor_two/data_models/marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class HttpService {
  final String studentsURL = "http://194.87.248.41:8080/markerGet.php";
  final String markerAdd = "http://194.87.248.41:8080/markerAdd.php";

  Future<List<UMarker>> getMarkers() async {
    Response res = await get(Uri.parse(studentsURL));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      List<UMarker> posts = body.map<UMarker>(
        (dynamic item) {
          return UMarker.fromJson(item);
        },
      ).toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<UMarker> markersAdd(UMarker marker) async {
    Response res = await post(Uri.parse(markerAdd), body: marker.toJson());
    if (res.statusCode == 200) {
      return UMarker(error: false);
    } else {
      return UMarker(error: true);
    }
  }
}
