import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostCategory extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  List<CategoryData> _categoryDataList = [];
  List<CategoryData> get categoryDataList => _categoryDataList;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchPostsByCategory(
      BuildContext context, int categoryId) async {
    if (categoryId == 0) {
      print('No category selected.');
      return;
    }

    setLoading(true);

    var url = Uri.parse(
        'https://citizen-femme.com/wp-json/custom/v1/posts?category_id=$categoryId');

    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> decodedResponse = jsonDecode(response.body);
        _categoryDataList = decodedResponse.map((category) {
          return CategoryData.fromJson(category);
        }).toList();
        notifyListeners();
      } else {
        print('Failed to load posts: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception during post fetch: $e');
    } finally {
      setLoading(false);
    }
  }
}

class CategoryData {
  final int id;
  final String title;
  final String imagePath;
  final String paragraph;

  CategoryData({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.paragraph,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      title: json['title'],
      imagePath: json['featured_image'],
      paragraph: json['short_content'],
    );
  }
}
