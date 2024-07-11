import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SinglePostCategory extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  List<SinglePostData> _singlePostDataList = [];
  List<SinglePostData> get singlePostDataList => _singlePostDataList;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchSinghPost(BuildContext context, int categoryId) async {
    setLoading(true);

    try {
      var url = Uri.parse(
          'https://citizen-femme.com/wp-json/custom/v1/post/$categoryId');
      print('Single post api $url');
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic decodedResponse = jsonDecode(response.body);
        print(response.body);

        if (decodedResponse is List) {
          _singlePostDataList = decodedResponse
              .map((post) =>
                  SinglePostData.fromJson(post as Map<String, dynamic>))
              .toList();
        } else if (decodedResponse is Map) {
          // Handle single object response
          _singlePostDataList = [
            SinglePostData.fromJson(decodedResponse as Map<String, dynamic>)
          ];
        } else {
          throw FormatException("Unexpected response format");
        }

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

class SinglePostData {
  final int id;
  final String title;
  final String imagePath;
  final String paragraph;
  final String authorName;
  final String createDate;

  SinglePostData({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.paragraph,
    required this.authorName,
    required this.createDate,
  });

  factory SinglePostData.fromJson(Map<String, dynamic> json) {
    return SinglePostData(
      id: json['id'],
      title: json['title'],
      imagePath: json['featured_image_url'],
      authorName: json['author_name'] ?? 'Unknown Author',
      createDate: json['created_date'] ?? 'Unknown Date',
      paragraph: json['content'],
    );
  }
}
