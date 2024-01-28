
import 'package:hive/hive.dart';

part 'ExpenseModel.g.dart';

@HiveType(typeId: 1)
class ExpenseModel {
  ExpenseModel({
    required this.reason,
    required this.amount,
    required this.date
  });
  @HiveField(0)
  final String reason;

  @HiveField(1)
  final int amount;

  @HiveField(2)
  final DateTime date;
}