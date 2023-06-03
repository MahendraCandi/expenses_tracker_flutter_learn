import 'package:expense_tracker/enums/category.dart';
import 'package:expense_tracker/models/expense_bucket.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const Chart({super.key, required this.expenses});

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.food),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (var bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          // start auto chart bar height
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var bucket in buckets)
                  ChartBar(
                      barHeight: bucket.totalExpenses == 0
                          ? 0
                          : bucket.totalExpenses / maxTotalExpense),
              ],
            ),
          ),
          //  end auto chart bar height
          const SizedBox(height: 12),
          // start chart bar icon
          Row(
            children: [
              ...buckets.map((e) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      e.category.icon.icon,
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
          // end chart bar icon
        ],
      ),
    );
  }

}
