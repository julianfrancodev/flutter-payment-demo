import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:payment_flutter_app/src/data/tarjetas.dart';
import 'package:payment_flutter_app/src/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagar"),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
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
                  return CreditCardWidget(
                      cardNumber: tarjeta.cardNumberHidden,
                      expiryDate: tarjeta.expiracyDate,
                      cardHolderName: tarjeta.cardHolderName,
                      cvvCode: tarjeta.cvv,
                      showBackView: false);
                }),
          ),
          Positioned(bottom: 0, child: TotalPayButton()),
        ],
      ),
    );
  }
}
