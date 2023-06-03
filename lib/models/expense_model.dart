import 'package:expense_tracker/constants/app_constant.dart';
import 'package:expense_tracker/enums/category.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  final Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
