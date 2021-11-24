import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  Color tMainColor = Color(0xff2F2165);
  Color t2MainColor = Color(0xff3C4858);
  Color mainColor = Color(0xff47536D);

  AppBar getAppBar(String text, bool _bool, context) {
    return AppBar(
      automaticallyImplyLeading: _bool,
      backgroundColor: mainColor,
      leading: _bool
          ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      )
          : null,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text('$text'),
      centerTitle: true,
    );
  }

  BoxShadow getBoxShadow() {
    return BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: 20,
        offset: Offset(2, 4));
  }
}