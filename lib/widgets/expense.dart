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
      useSafeArea: true, // to avoid front camera
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
    // to adjust responsive,
    // we could play with width and height of screen
    // And also we could using Column and Row widget
    //
    // if width is less than height then we could use Column widget as body
    // if width is higher than height then we could use Row Widget as body
    var screenWidth = MediaQuery.of(context).size.width;
    // var screenHeight = MediaQuery.of(context).size.height;


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
      body: screenWidth < 600
          ? bodyAsColumn(mainContent)
          : bodyAsRow(mainContent),
    );
  }

  Column bodyAsColumn(Widget mainContent) {
    return Column(
      children: [
        Chart(expenses: _expenses),
        Expanded(
          child: mainContent,
        ),
      ],
    );
  }

  // SIZE CONSTRAINT
  //
  // every widget has different size preference, for example:
  // Column widget
  // height preference: take as much as possible
  // width preference: take as much as by children needed
  //
  // Widget size should be depending on size preferences and their parent size constraint
  // For example if Column is set inside a Scaffold widget,
  // because Scaffold has height and width preference to take maximum device size,
  // then this may impact the Column size to become
  // height: will take maximum device size (because of Scaffold height)
  // width: still depends on the children
  //
  // Other widget constraint example,
  // A Column X with
  // height: INFINITY
  // width: 0 -> depends on children
  //
  // Inside Column X will have a Row with
  // height: 0 -> depends on children
  // width: INFINITY
  //
  // And inside Column X will have a Column Y with
  // height: INFINITY
  // width: 0 -> depends on children
  //
  // Unfortunately, this Column Y will causing error because
  // there is no parent constraint from the parent (Column X)

  // SIZE CONSTRAINT REAL CASE
  // Row (parent) have infinity width, And also the Chart (children).
  // This will cause an error, because the parent and the children will take as much as possible width
  // To resolve this issue, we could wrap the children by using Expanded widget
  // Expanded widget would constraint the children to only take as much width as available in parent
  Row bodyAsRow(Widget mainContent) {
    return Row( // Row widget have infinity width
      children: [
        Expanded(
          child: Chart(expenses: _expenses), // Chart widget has been set with infinity width
        ),
        Expanded(
          child: mainContent,
        ),
      ],
    );
  }
}
