import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_gallery/model/image_model.dart';

class ApiService {
  final String api_key = "46338352-a5ea3cecdbfd5fbd4b2baf3c1";

  late String url;

  Future<ImageModel> fetchImages(int page, int perPage,
      {String? searchText}) async {
    String query =
        searchText != null ? searchText.replaceAll(RegExp(r'\s+'), '') : "";
    url =
        'https://pixabay.com/api/?key=$api_key&q=$query&image_type=photo&page=$page&per_page=$perPage';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return ImageModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load users');
    }
  }
}
