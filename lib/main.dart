import 'package:flutter/material.dart';
import 'package:flutter_memory/memory.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Memory()
    );
  }
}

