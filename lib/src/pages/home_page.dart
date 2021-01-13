import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:payment_flutter_app/bloc/pay_bloc/pay_bloc.dart';
import 'package:payment_flutter_app/helpers/helpers.dart';
import 'package:payment_flutter_app/services/stripe_service.dart';
import 'package:payment_flutter_app/src/data/tarjetas.dart';
import 'package:payment_flutter_app/src/pages/card_page.dart';
import 'package:payment_flutter_app/src/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  final stripeService = new StripeService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final paymentBloc = BlocProvider.of<PayBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagar"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {

                final amount = paymentBloc.state.monto.floor().toString();

                final currency = paymentBloc.state.moneda;



                final resp = await stripeService.pagarConNuevaTarjeta(
                    amount: amount, currency: currency);

                if(resp.ok){
                  showAlert(context, "Tarjeta Ok", "Todo correcto");
                }else{
                  showAlert(context, "Algo Salio Mal", resp.msg);
                }
              })
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: PageController(viewportFraction: 0.9),
                itemCount: tarjetas.length,
                itemBuilder: (_, i) {
                  final tarjeta = tarjetas[i];
                  return GestureDetector(
                    onTap: () {
                      paymentBloc.add(OnSeleccionarTarjeta(tarjeta));
                      Navigator.push(
                          context, navegarMapaFadeIn(context, CardPage()));
                    },
                    child: Hero(
                      tag: tarjeta.cardNumber,
                      child: CreditCardWidget(
                          cardNumber: tarjeta.cardNumberHidden,
                          expiryDate: tarjeta.expiracyDate,
                          cardHolderName: tarjeta.cardHolderName,
                          cvvCode: tarjeta.cvv,
                          showBackView: false),
                    ),
                  );
                }),
          ),
          Positioned(bottom: 0, child: TotalPayButton()),
        ],
      ),
    );
  }
}
