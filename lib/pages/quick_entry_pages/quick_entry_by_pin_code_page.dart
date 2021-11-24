import 'package:flutter/material.dart';
import 'package:flutter_7food_courier/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_dot/pin_dot.dart';
import 'package:pin_keyboard/pin_keyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class QuickEntryPage extends StatefulWidget {
  @override
  _QuickEntryPageState createState() => _QuickEntryPageState();
}

class _QuickEntryPageState extends State<QuickEntryPage> {
  String _code = '';
  Constants _constants = Constants();
  late Size screenSize;

  @override
  void initState() {
    biometricAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.1,
              vertical: screenSize.width * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Бытрый вход',
                style: TextStyle(color: _constants.t2MainColor, fontSize: 24),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Text(
                'Введи код доступа к приложению',
                textAlign: TextAlign.center,
                style: TextStyle(color: _constants.t2MainColor, fontSize: 16),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              PinDot(
                size: 16,
                length: 4,
                text: _code,
                inactiveColor: Color(0xffC4C4C4),
                activeColor: _constants.t2MainColor,
                borderColor: Color(0xffC4C4C4),
              ),
              Spacer(),
              PinKeyboard(
                maxWidth: screenSize.width * 0.9,
                length: 4,
                enableBiometric: true,
                textColor: Colors.black,
                iconBiometricColor: Colors.black,
                iconBackspaceColor: Colors.black,
                onChange: (pin) {
                  setState(() {
                    _code = pin;
                  });
                },
                onConfirm: (pin) async {
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  String? _correctPin = _prefs.getString('code');
                  if (pin == _correctPin) {
                    _code = '';
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Неправильный код доступа',
                        gravity: ToastGravity.CENTER,
                        backgroundColor: _constants.t2MainColor,
                        fontSize: 16);
                    _code = '';
                  }
                },
                onBiometric: () {
                  biometricAuth();
                },
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<void> biometricAuth() async {
    bool _authenticated = false;

    try {
      var _auth = LocalAuthentication();
      const androidStrings = const AndroidAuthMessages(
        biometricHint: '',
        cancelButton: 'Отмена',
        signInTitle: 'Используйте Touch ID для "7food"',
      );
      _authenticated = await _auth.authenticate(
        localizedReason: 'Приложите палец, чтобы войти в приложение',
        androidAuthStrings: androidStrings,
        biometricOnly: true,
        useErrorDialogs: false,
      );
      setState(() {
        _authenticated
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (e) => false)
            : null;
      });
    } catch (e) {
      print(e);
    }
  }
}
