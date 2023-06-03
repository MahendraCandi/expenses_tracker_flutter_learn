
import 'package:expense_tracker/constants/app_constant.dart';
import 'package:expense_tracker/enums/category.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  final void Function(ExpenseModel expenseModel) insertExpense;

  const AddExpense({super.key, required this.insertExpense});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _openDatePicker() async {
    var now = DateTime.now();
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _setCategory(value) {
    if (value == null) {
      return;
    }

    setState(() {
      _selectedCategory = value;
    });
  }

  void _submitExpense() {
    var amount = double.tryParse(_amountController.text);
    var title = _titleController.text;

    if (title.isEmpty ||
        (amount == null || amount < 0) ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text("You have invalid input data"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text("okay")),
          ],
        ),
      );
      return;
    }

    var expenseModel = ExpenseModel(title: title, amount: amount, date: _selectedDate!, category: _selectedCategory!);
    widget.insertExpense(expenseModel);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            // onChanged: _saveTitle,
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefixText: "\$",
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null ? "No date selected" : dateFormatter.format(_selectedDate!)),
                    IconButton(onPressed: _openDatePicker, icon: const Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.name.toUpperCase(),
                    ),
                  ),
                ).toList(),
                onChanged: _setCategory,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text("Save"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              )
            ],
          )
        ],
      ),
    );
  }
}
