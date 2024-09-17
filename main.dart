import 'package:dummy/home.dart';
import 'package:dummy/profile.dart';
import 'package:flutter/material.dart';
import 'package:dummy/otp.dart';
import 'package:dummy/phoneno.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    routes: {
      'home': (context)=>MyHome(),
      'phoneno': (context) => MyPhone(),
      'otp': (context) => MyOtp(verificationId: '',),
      'profile':(context)=>MyProfile()
    },
  ));
}

