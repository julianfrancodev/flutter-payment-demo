import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:payment_flutter_app/src/models/payment_intent.dart';
import 'package:payment_flutter_app/src/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  //Singleton

  StripeService._privateConstructor();

  static final StripeService _instance = StripeService._privateConstructor();

  factory StripeService() {
    return _instance;
  }

  String _paymentApiUrl = "https://api.stripe.com/v1/payment_intents";
  static String _secretKey =
      "sk_test_51I7tjaBc8UD4HgB5S4iXPdOONM48zHM6cbNYpg5bXx9UUXBVD6W6o6j1W5ixU2pLBLqg0YvcH4wUBKJIwWsUoh35000ftXSDJf";
  String _apiKey =
      "pk_test_51I7tjaBc8UD4HgB524pyLvT81nFzXBId9tmj2M6cx9XrfnflOkMobjDXAAxrkNHUb8QtAwI5oMW1P35QoCBUImUz00E8PevqDs";

  final headerOptions = new Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {"Authorization": "Bearer ${StripeService._secretKey}"});

  void init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: this._apiKey,
        androidPayMode: "test",
        merchantId: "test"));
  }

  Future pagarConTarjeta(
      {@required String amount,
      @required String currency,
      @required CreditCard card}) async {}

  Future<StripeCustomResponse> pagarConNuevaTarjeta(
      {@required String amount, @required String currency}) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());

      final resp = await this._realizarPago(
          amount: amount, currency: currency, paymentMethod: paymentMethod);

      return resp;
    } catch (error) {
      return StripeCustomResponse(ok: false, msg: error.toString());
    }
  }

  Future<StripeCustomResponse> pagarApplePayGooglePay(
      {@required String amount, @required String currency}) async {
    try {
      final token = await StripePayment.paymentRequestWithNativePay(
          androidPayOptions: AndroidPayPaymentRequest(
              currencyCode: currency, totalPrice: amount),
          applePayOptions: ApplePayPaymentOptions(
              countryCode: "USD",
              currencyCode: currency,
              items: [
                ApplePayItem(label: "Producto 1", amount: amount)
              ]));
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: "Fallo Intenta de nuevo");
    }
  }

  Future<StripeCustomResponse> pagarConTarjetaExistente(
      {@required String amount,
      @required String currency,
      @required CreditCard card}) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));

      final resp = await this._realizarPago(
          amount: amount, currency: currency, paymentMethod: paymentMethod);

      return resp;
    } catch (error) {
      return StripeCustomResponse(ok: false, msg: error.toString());
    }
  }

  Future _crearPaymentIntent(
      {@required String amount, @required String currency}) async {
    try {
      final dio = new Dio();

      final data = {"amount": amount, "currency": currency};

      final response = await dio.post(this._paymentApiUrl,
          data: data, options: headerOptions);

      return PaymentIntentResponse.fromJson(response.data);
    } catch (error) {
      print(error);
      return PaymentIntentResponse(status: "400");
    }
  }

  Future<StripeCustomResponse> _realizarPago(
      {@required String amount,
      @required String currency,
      @required PaymentMethod paymentMethod}) async {
    try {
      final PaymentIntentResponse paymentIntent =
          await this._crearPaymentIntent(amount: amount, currency: currency);

      final paymentResult =
          await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: paymentIntent.clientSecret,
        paymentMethodId: paymentMethod.id,
      ));

      if (paymentResult.status == "succeeded") {
        return StripeCustomResponse(ok: true);
      } else {
        return StripeCustomResponse(
            ok: false, msg: "Fallo ${paymentResult.status}");
      }
    } catch (e) {
      print(e);

      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }
}
