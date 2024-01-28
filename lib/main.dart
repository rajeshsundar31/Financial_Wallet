import 'dart:async';

import 'package:fin_anly/views/handle.dart';
import 'package:fin_anly/model/ExpenseModel.dart';
import 'package:fin_anly/utils/expenseslist.dart';
import 'package:fin_anly/views/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51O3X03SCjJF4RQVbLjwNSpSArhf0lISnz15OQlrILv8tOvjFpekMKStuAzOqDhl2HxEz4s0xtcgcqDQcUxDQX9f600WcvUslMM';
  Hive.registerAdapter(ExpenseModelAdapter());
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const Scaffold(
      body: Center(
        child: Text("Something Went Wrong..."),
      ),
    );
    
  };

  expenseslist = await Hive.openBox<ExpenseModel>('expense');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    const Financial()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Lottie.asset(
                  'lib/assets/json/fin.json',
                  width: 550
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child:  Text("Financial Wallet",textAlign:TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}