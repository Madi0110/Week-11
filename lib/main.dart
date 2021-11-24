// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_7food_courier/pages/quick_entry_pages/quick_entry_by_pin_code_page.dart';
import 'package:flutter_7food_courier/pages/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({@required this.prefs});

  @override
  Widget build(BuildContext context) {
    String _token = prefs.getString('token');
    print('TOKEN: $_token');
    if (_token == null) print('Has no TOkEN');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _token == null ? SignInPage() : QuickEntryPage());
  }
}
