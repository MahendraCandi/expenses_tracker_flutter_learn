import 'package:expense_tracker/enums/category.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expenses;

  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // alternative constructor
  ExpenseBucket.forCategory(List<ExpenseModel> expenseList, this.category)
      : expenses = expenseList
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
