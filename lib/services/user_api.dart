import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learn_api/services/utility/app_url.dart';
import '../models/user.dart';

class UserAPI {
  static Future<List<User>> randomUser() async {
    debugPrint('API called');
    final response = await http.get(Uri.parse(AppUrl.randomBaseUrl));
    final data = jsonDecode(response.body);
    final result = data['results'] as List<dynamic>;
    final users = result.map((e) {
      return User.fromMap(e);
    }).toList();
    debugPrint('API call Completed');
    return users;
  }

  static Future<dynamic> getUser() async {
    final response = await http.get(Uri.parse(AppUrl.randomBaseUrl));
   var data = jsonDecode(response.body);
    
    return data;
  }
}
