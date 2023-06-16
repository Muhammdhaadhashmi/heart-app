import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/screens/home_screen.dart';
import 'package:firebase_signin/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'Utils/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Column(
        children: [
          SizedBox(height: 190,),
          Text("HeartCare",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
          SizedBox(height: 200,),
          Center(
            child: Image.asset(
              "assets/images/logo2.png",
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
