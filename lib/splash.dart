import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/Createprofile.dart';
import 'package:todo_list/View.dart';
import 'package:todo_list/alldata.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    Future.delayed(Duration(seconds: 2), () async {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // bool loginstatus = await preferences.getBool('login') ?? false;
      // if (loginstatus) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => AllData()));
      // } else
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Createprofile()));

      //
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(children: [
            Image.asset("assets/images/todo.png"),
            SizedBox(
              height: 50,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('TODO LIST',
                    textStyle:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                // TyperAnimatedText('HuB',
                //     textStyle:
                //         TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ],
            ),
          ]),
        ));
  }
}
