import 'package:fin_anly/model/ExpenseModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ListViewDetails extends StatelessWidget {
  final ExpenseModel expenseModel;
  const ListViewDetails({
    required this.expenseModel,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          children: [
             Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,left:15),
                  child: Text(expenseModel.reason),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 230),
                  child: Text(expenseModel.amount.toString()),
                )
              ],
            ),
            Padding(
                  padding: const EdgeInsets.only(top: 10,right: 240),
                  child: Text(DateFormat.yMMMMd().format(expenseModel.date)),
                )
          ],
        ),
      ),
    );
  }
}