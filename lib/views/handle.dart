import 'package:fin_anly/controller/payment_controller.dart';
import 'package:fin_anly/model/ExpenseModel.dart';
import 'package:fin_anly/views/page.dart';
import 'package:fin_anly/utils/expenseslist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Financial extends StatefulWidget {
  const Financial({super.key});

  @override
  State<Financial> createState() => _FinancialState();
}

class _FinancialState extends State<Financial> {
  final PaymentController controller = Get.put(PaymentController());

  final reasoncontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  final datecontroller = TextEditingController();
  DateTime? pickedDate;
  int totalamount = 0;
  

  showDialogbox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Your Expanses"),
            content: SizedBox(
              height: 250,
              child: Column(
                children: [
                  TextFormField(
                    controller: amountcontroller,
                    decoration: const InputDecoration(
                        labelText: "Amount", border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        )),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: reasoncontroller,
                    decoration: const InputDecoration(
                        labelText: "Expanse Reason",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        )),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: datecontroller,
                    onTap: () async {
                      pickedDate = await showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime(2000), 
                        lastDate: DateTime(2100)
                        );
                        String convertedDate = DateFormat().add_yMMMd().format(pickedDate!);
                        datecontroller.text = convertedDate;
                        setState(() { });
                    },
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          )),
                    ),
                  
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    totalamount += int.parse(amountcontroller.text);
                    expenseslist.put('_key${reasoncontroller.text}', 
                    ExpenseModel(
                      reason: reasoncontroller.text, 
                      amount: int.parse(amountcontroller.text), 
                      date: pickedDate!));
                      controller.makePayment(amount: amountcontroller.text);
                  });
                  
                  // var amount1 = int.parse(amountcontroller.text);
                  // final expens = ExpenseModel(
                  //   reason: reasoncontroller.text, 
                  //   amount: amount1, 
                  //   date: pickedDate!);

                  //   setState(() {
                  //     totalamount += amount1;
                  //   });
                    
                  //   expenses.add(expens);
                    reasoncontroller.clear();
                    amountcontroller.clear();
                    datecontroller.clear(); 
                    Navigator.pop(context);

              }, child: const Text('save')),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: const Text('cancel'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding:  const EdgeInsets.all(15.0),
            child: Container(
              width: 390,
              height: 170,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black),
                  borderRadius:  const BorderRadius.all(Radius.circular(10)),
                  image:  const DecorationImage(
                      image: AssetImage("lib/assets/images/map.jpg"),
                      opacity: 0.3,
                      fit: BoxFit.cover),
                  color:  const Color.fromARGB(255, 12, 57, 99)),
              child:  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Total Exp: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                         ' $totalamount',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 15, 214, 104),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.wallet,
                            color: Colors.yellow,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 190),
                    child: Image(
                      image: AssetImage("lib/assets/images/chip.png"),
                      width: 50,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40, left: 15),
                    child: Row(
                      children: [
                        Text(
                          '*********913 Bank of UKT',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: expenseslist.length,
                  itemBuilder: (context, index) {
                    ExpenseModel expense = expenseslist.getAt(index);
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const StretchMotion(), 
                      children: [
                        SlidableAction(onPressed: (context){
                          expenseslist.deleteAt(index);
                        }, 
                        backgroundColor: Colors.red, 
                        icon: Icons.delete, 
                        label: 'Delete',)
                      ]),
                    child: 
                    ListViewDetails(
                      expenseModel: ExpenseModel(
                        reason: expense.reason, 
                        amount: expense.amount, 
                        date: expense.date),
                    ));
                  },
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogbox(context);
          // controller.makePayment(amount: '136');
        },
        backgroundColor: const Color.fromARGB(255, 12, 57, 99),
        child:Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:Icon(Icons.home)
                ),
              ),
            ),
      ),
    ));
  }
}
