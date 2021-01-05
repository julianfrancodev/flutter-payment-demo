import 'package:flutter/material.dart';
import 'package:payment_flutter_app/src/pages/home_page.dart';
import 'package:payment_flutter_app/src/routes/routes.dart';

void main(){
  runApp(
    MaterialApp(
      title: "Payment app",
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: "home",
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xff284879),
        scaffoldBackgroundColor: Color(0xff21232a)
      ),
    )
  );
}