import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expenseModel) onRemoveExpense;

  const ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.50),
          margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        child: ExpensesItem(
          expenseModel: expenses[index],
        ),
      ),
    );
  }
}
