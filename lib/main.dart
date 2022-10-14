import 'package:flutter/material.dart';
import 'package:todo_list/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}
