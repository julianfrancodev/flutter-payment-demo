import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payment_flutter_app/src/bloc/pay_bloc/pay_bloc.dart';
import 'package:payment_flutter_app/src/helpers/helpers.dart';
import 'package:payment_flutter_app/src/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final paymentBloc = BlocProvider.of<PayBloc>(context);

    return Container(
        width: width,
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("${paymentBloc.state.monto} ${paymentBloc.state.monto}",
                    style: TextStyle(
                      fontSize: 20,
                    ))
              ],
            ),
            _BtnPay(),
          ],
        ));
  }
}

class _BtnPay extends StatelessWidget {
  Widget buildButtonCard(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        showLoading(context);

        final StripeService stripeService = new StripeService();
        final payBloc = BlocProvider.of<PayBloc>(context).state;

        final monthYear = payBloc.tarjetaCredito.expiracyDate.split("/");

        final resp = await stripeService.pagarConTarjetaExistente(
            amount: payBloc.monto.toString(),
            currency: payBloc.moneda,
            card: CreditCard(
              number: payBloc.tarjetaCredito.cardNumber,
              expMonth: int.parse(monthYear[0]),
              expYear: int.parse(monthYear[1]),
            ));

        Navigator.pop(context);

        if (resp.ok) {
          showAlert(context, "Tarjeta Validada", "Todo correcto");
        } else {
          showAlert(
              context, "El Pago no se puedo realizar", "Intenta nuevamente");
        }
      },
      height: 45,
      minWidth: 170,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.solidCreditCard,
            color: Colors.white,
            size: 20,
          ),
          Text(
            "  Pagar",
            style: TextStyle(color: Colors.white, fontSize: 22),
          )
        ],
      ),
    );
  }

  Widget buildAppleAndGoogle(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        final StripeService stripeService = new StripeService();
        final payBloc = BlocProvider.of<PayBloc>(context).state;

        final resp = await stripeService.pagarApplePayGooglePay(
            amount: payBloc.monto.toString(), currency: payBloc.moneda);
      },
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            Platform.isAndroid
                ? FontAwesomeIcons.google
                : FontAwesomeIcons.apple,
            color: Colors.white,
            size: 20,
          ),
          Text(
            " Pay",
            style: TextStyle(color: Colors.white, fontSize: 22),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return true ? buildAppleAndGoogle(context) : buildAppleAndGoogle(context);
  }
}
