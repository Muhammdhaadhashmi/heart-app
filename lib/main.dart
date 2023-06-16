import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_signin/screens/home_screen.dart';
import 'package:firebase_signin/screens/signin_screen.dart';
import 'package:firebase_signin/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // Set this to false in release mode
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heart Disease Classifier',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const SplashView(),
    );
  }
}
