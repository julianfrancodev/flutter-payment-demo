import 'package:flutter/material.dart';
import 'package:payment_flutter_app/src/pages/card_page.dart';
import 'package:payment_flutter_app/src/pages/home_page.dart';
import 'package:payment_flutter_app/src/pages/payment_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "home": (_) => HomePage(),
  "card": (_) => CardPage(),
  "payment": (_) => PaymentPage()
};
