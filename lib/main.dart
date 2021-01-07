import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_flutter_app/bloc/pay_bloc/pay_bloc.dart';
import 'package:payment_flutter_app/src/pages/home_page.dart';
import 'package:payment_flutter_app/src/routes/routes.dart';

void main(){
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create:  (_)=> PayBloc())
      ],
      child: MaterialApp(
        title: "Payment app",
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: "home",
        theme: ThemeData.light().copyWith(
          primaryColor: Color(0xff284879),
          scaffoldBackgroundColor: Color(0xff21232a)
        ),
      ),
    )
  );
}