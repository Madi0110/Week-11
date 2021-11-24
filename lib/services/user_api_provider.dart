import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_7food_courier/pages/quick_entry_pages/enter_new_pin_code.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<void> loginByPassword(String phone, String password, context) async {
    print(phone);
    final response = await http.post(Uri.parse(
        'https://7food.kz/api/auth/login?phone=7$phone&password=$password'));
    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewQuickEntryPage()));
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String _token = json.decode(response.body)['token'];
      int _id = json.decode(response.body)['id'];
      _prefs.setString('token', _token);
      _prefs.setInt('id', _id);
      print('${_prefs.getInt('id')}');
    } else {
      print(response.statusCode);
      throw Exception('Failed to load fridge');
    }
  }
}
