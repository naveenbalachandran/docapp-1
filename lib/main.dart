import 'package:docapp/screen_details.dart';
import 'package:docapp/screen_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocApp',
      debugShowCheckedModeBanner: false,
      home: ScreenHome(),
      // routes: {
      //   'HomeScreen':(ctx){return ScreenHome();}
      //   'DetailsScreen':(ctx){return ScreenDetails(model: ,);}
      // },
    );
  }
}
