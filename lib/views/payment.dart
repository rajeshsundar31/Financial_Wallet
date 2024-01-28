import 'package:fin_anly/controller/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class PaymentSheet extends StatefulWidget {
  const PaymentSheet({super.key});

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  final PaymentController controller = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Center(
              child: CardFormField(),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  // await Stripe.instance.presentPaymentSheet();
                controller.makePayment(amount: '133');
              }, child: Text("Pay me!")),
            )
          ],
        ),
      )
      );
  }
}