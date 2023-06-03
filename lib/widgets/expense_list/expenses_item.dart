import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  final ExpenseModel expenseModel;

  const ExpensesItem({super.key, required this.expenseModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseModel.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(children: [
              Text("\$${expenseModel.amount.toStringAsFixed(2)}"),
              const Spacer(),
              Row(children: [
                expenseModel.category.icon,
                const SizedBox(width: 8,),
                Text(expenseModel.formattedDate)
              ],)
            ],)
          ],
        ),
      ),
    );
  }
}
