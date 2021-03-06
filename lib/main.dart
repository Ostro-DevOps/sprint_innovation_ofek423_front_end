import 'package:flutter/material.dart';
import 'Components/open_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Color(0XffF3C33F), //yellow color for appBar
      ),
      home: OpenPageState("yosi"),
    );
  }
}
