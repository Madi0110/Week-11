import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_7food_courier/constants.dart';
import 'package:pin_dot/pin_dot.dart';
import 'package:pin_keyboard/pin_keyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class NewQuickEntryPage extends StatefulWidget {
  @override
  _NewQuickEntryPageState createState() => _NewQuickEntryPageState();
}

class _NewQuickEntryPageState extends State<NewQuickEntryPage> {
  String _code = '';
  String _code_second = '';
  bool _entered = false;
  Constants _constants = Constants();
  late Size screenSize;

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
                'Придумайте пароль для бытрого входа',
                textAlign: TextAlign.center,
                style: TextStyle(color: _constants.t2MainColor, fontSize: 24),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              !_entered
                  ? Text(
                      'Введите код доступа к приложению',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: _constants.t2MainColor, fontSize: 16),
                    )
                  : Text(
                      'Повторно введите код доступа',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: _constants.t2MainColor, fontSize: 16),
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
                maxWidth: screenSize.width * 0.8,
                length: 4,
                enableBiometric: false,
                textColor: Colors.black,
                iconBiometricColor: Colors.white,
                iconBackspaceColor: Colors.black,
                onChange: (pin) {
                  setState(() {
                    _code = pin;
                  });
                },
                onConfirm: (pin) async {
                  if (_entered == false) {
                    _code_second = pin;
                    _code = '';
                    _entered = true;
                  }
                  if (_code_second == _code) {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    _prefs.setString('code', _code);
                    print('Pin Code: ${_prefs.getString('code')}');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  }
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
