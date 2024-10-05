import 'package:flutter/material.dart';
import 'package:web_gallery/model/image_model.dart';
import 'package:web_gallery/service/api_service.dart';

class ImagesProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  ImageModel _imageList = ImageModel();
  bool _isLoading = false;

  ImageModel get images => _imageList;
  bool get isLoading => _isLoading;
  Future<void> notify() async {
    notifyListeners();
  }
  Future<void> fetchImages(int page,int perPage,{String? searchText}) async {
    _isLoading = true;
    // notifyListeners();  // Notify UI to show the loading indicator

    try {
      _imageList = await apiService.fetchImages(page,perPage,searchText: searchText);
      print(_imageList.hits?.length);
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();  // Notify UI to show the data
  }
}
