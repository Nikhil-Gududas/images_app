import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:images_app/views/home.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              centerTitle: true),
          primaryColor: Colors.white),
      title: 'Images App',
      home: const Home(),
    );
  }
}
