import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:payment_flutter_app/bloc/pay_bloc/pay_bloc.dart';
import 'package:payment_flutter_app/src/widgets/total_pay_button.dart';

class CardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final blocPayment = BlocProvider.of<PayBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagar"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            blocPayment.add(OnDesactivarTarjeta());
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(),
          BlocBuilder<PayBloc, PayState>(
            builder: (context, state) {
              return Hero(
                tag: blocPayment.state.tarjetaCredito.cardNumber,
                child: CreditCardWidget(
                    cardNumber: blocPayment.state.tarjetaCredito.cardNumber,
                    expiryDate: blocPayment.state.tarjetaCredito.expiracyDate,
                    cardHolderName:
                        blocPayment.state.tarjetaCredito.cardHolderName,
                    cvvCode: blocPayment.state.tarjetaCredito.cvv,
                    showBackView: false),
              );
            },
          ),
          Positioned(bottom: 0, child: TotalPayButton()),
        ],
      ),
    );
  }
}
