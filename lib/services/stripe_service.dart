import 'package:flutter/cupertino.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  //Singleton

  StripeService._privateConstructor();

  static final StripeService _instance = StripeService._privateConstructor();

  factory StripeService() {
    return _instance;
  }

  String _paymentApiUrl = "https://api.stripe.com/v1/payment_intents";
  String _secretKey =
      "sk_test_51I7tjaBc8UD4HgB5S4iXPdOONM48zHM6cbNYpg5bXx9UUXBVD6W6o6j1W5ixU2pLBLqg0YvcH4wUBKJIwWsUoh35000ftXSDJf";

  void init() {}

  Future pagarConTarjeta(
      {@required String amount,
      @required String currency,
      @required CreditCard card}) async {}

  Future pagarConNuevaTarjeta(
      {@required String amount, @required String currency}) async {}

  Future pagarApplePayGooglePay(
      {@required String amount, @required String currency}) async {}

  Future _crearPaymentIntent(
      {@required String amount, @required String currency}) async {}

  Future _realizarPago(
      {@required String amount,
      @required String currency,
      @required PaymentMethod paymentMethod}) async {}
}
