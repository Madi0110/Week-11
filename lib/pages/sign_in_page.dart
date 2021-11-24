import 'package:flutter/material.dart';
import 'package:flutter_7food_courier/constants.dart';
import 'package:flutter_7food_courier/services/user_api_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  Constants _constants = Constants();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: screenSize.height * 0.45,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _constants.mainColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: screenSize.height * 0.05,
                  left: screenSize.width * 0.1,
                  right: screenSize.width * 0.1),
              margin: EdgeInsets.all(screenSize.width * 0.1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      // spreadRadius: 1,
                      offset: Offset(0, 4))
                ],
                color: Colors.white,
              ),
              child: Form(
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Вход',
                          style: TextStyle(color: _constants.t2MainColor),
                        ),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          maskFormatter,
                        ],
                        decoration: InputDecoration(
                          prefix: Text(
                            '+7 ',
                            style: TextStyle(color: Colors.black),
                          ),
                          labelText: 'Номер',
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      )
                    ]),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: screenSize.height * 0.615, left: screenSize.width * 0.37),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(_constants.mainColor)),
              onPressed: () async {
                await UserService().loginByPassword(
                    maskFormatter.getUnmaskedText(),
                    _passwordController.text,
                    context);
              },
              child: Text(
                'Отправить',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
