import 'package:flutter/material.dart';
// import 'package:api_practice/home_screen.dart';
// import './exampleTwo.dart';
// import './exampleThree.dart';
import 'signup.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Signup() 
      // home: const Examplethree() 
      // home: const Exampletwo() 
      // home: const HomeScreen() 
    );
  }
}