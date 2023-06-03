import 'package:expense_tracker/enums/category.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/add_expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _expenses = [
    ExpenseModel(title: "Flutter course", amount: 20.00, date: DateTime.now(), category: Category.work),
    ExpenseModel(title: "Cinema", amount: 3.50, date: DateTime.now(), category: Category.leisure),
    ExpenseModel(title: "Taxi", amount: 6.00, date: DateTime.now(), category: Category.work),
  ];
  
  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(
        insertExpense: _insertExpense,
      ),
    );
  }

  void _insertExpense(ExpenseModel expenseModel) {
    setState(() {
      _expenses.add(expenseModel);
    });
  }

  void _removeExpense(ExpenseModel expenseModel) {
    final expenseIndex = _expenses.indexOf(expenseModel);
    setState(() {
      _expenses.removeAt(expenseIndex);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text("Expense deleted!"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _expenses.insert(expenseIndex, expenseModel);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("Start adding expense!",),);

    if (_expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _expenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
