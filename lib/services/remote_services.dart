import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:images_app/model/photo_model.dart';
import 'package:http/http.dart' as http;

class RemoteServces {
  static final apiKey = dotenv.env['API_KEY'] ?? 'Api Key not found';
  getTrendingPhotos() async {
    var client = http.Client();
    var uri = Uri.parse("https://api.pexels.com/v1/curated?per_page=30&page=1");
    var response = await client.get(uri, headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      var json = response.body;
      return photoModelFromJson(json);
    }
  }

  getPhotosByQuery(String query) async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1");
    var response = await client.get(uri, headers: {"Authorization": apiKey});
    if (response.statusCode == 200) {
      var json = response.body;
      return photoModelFromJson(json);
    }
  }
}
