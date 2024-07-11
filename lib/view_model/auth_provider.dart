import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:citizen_femme/view/home.dart';

class AuthProvider extends ChangeNotifier {
  bool _isRemember = false;
  bool get isRemember => _isRemember;

  bool _loading = false;
  bool get loading => _loading;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  bool _Submitted = false;
  bool get Submitted => _Submitted;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setRemember(bool val) {
    _isRemember = val;
    notifyListeners();
  }

  Future<void> login(
      String username, String password, BuildContext context) async {
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = json.encode({
      'username': username,
      'password': password,
    });

    try {
      var response = await http.post(
        Uri.parse('https://citizen-femme.com/wp-json/custom/v1/login'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Successful');
        _loggedIn = true; // Update the loggedIn state
        // Navigate to home screen upon successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print('Failed with status code: ${response.statusCode}');
        // Handle failure scenario here (e.g., show error message)
      }
    } catch (e) {
      print('Exception during login: $e');
      // Handle exceptions or errors
    } finally {
      setLoading(false);
    }
  }

  Future<void> ConstactUs(String input_1, String input_3, String input_4,
      String input_5, BuildContext context) async {
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = json.encode({
      'input_1': input_1,
      'input_3': input_3,
      'input_4': input_4,
      'input_5': input_5,
    });

    http.Request request = http.Request(
      'POST',
      Uri.parse('https://citizen-femme.com/wp-json/gf/v2/forms/1/submissions'),
    );
    request.headers.addAll(headers);
    request.body = body;

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('Successful');
        _Submitted = true; // Update the loggedIn state
      } else {
        print('Failed with status code: ${response.statusCode}');
        // Handle failure scenario here (e.g., show error message)
      }
    } catch (e) {
      print('Exception during login: $e');
      // Handle exceptions or errors
    } finally {
      setLoading(false);
    }
  }
}
