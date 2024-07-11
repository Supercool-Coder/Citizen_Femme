import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  List<ImageData> _categories = [];
  List<ImageData> get categories => _categories;

  String _selectedCategoryName = ''; // Define selectedCategoryName
  int _selectedCategoryId = 0; // Define selectedCategoryId

  String get selectedCategoryName =>
      _selectedCategoryName; // Getter for selectedCategoryName
  int get selectedCategoryId => _selectedCategoryId;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    setLoading(true);

    var url =
        Uri.parse('https://citizen-femme.com/wp-json/custom/v1/categories');

    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(response.body);
        _categories = decodedResponse.map((category) {
          return ImageData.fromJson(category);
        }).toList();
        notifyListeners();
      } else {
        print('Failed to load categories: ${response.reasonPhrase}');
        // Handle failure scenario here (e.g., show error message)
      }
    } catch (e) {
      print('Exception during category fetch: $e');
      // Handle exceptions or errors
    } finally {
      setLoading(false);
    }
  }

  void fetchPostsByCategory() {}

  void selectCategory(int id, String name) {}
}

class ImageData {
  final String imagePath;
  final String name;
  final int id; // Include id in the model

  ImageData({
    required this.imagePath,
    required this.name,
    required this.id,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imagePath:
          'assets/images/image1.png', // Adjust if actual image URL is available
      name: json['name'],
      id: json['id'], // Assign id from JSON
    );
  }
}
