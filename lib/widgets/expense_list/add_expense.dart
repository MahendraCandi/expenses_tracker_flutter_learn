
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
    // to get keyboard size that used in screen.
    // to adjust the form in landscaped mode
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // instead using media query to make screen responsive, we could use LayoutBuilder to get width and height max size
    return LayoutBuilder(builder: (context, constraint) {
      var maxWidth = constraint.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (isLandscaped(maxWidth))
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: titleInputText()),
                      const SizedBox(width: 8),
                      Expanded(child: amountInputText()),
                    ],
                  )
                else
                  titleInputText(),
                if (isLandscaped(maxWidth))
                  Row(
                    children: [
                      categoryDropdown(),
                      const SizedBox(width: 16),
                      Expanded(child: dateInputPicker()),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(child: amountInputText()),
                      const SizedBox(width: 16),
                      Expanded(child: dateInputPicker()),
                    ],
                  ),
                const SizedBox(height: 8),
                if (isLandscaped(maxWidth))
                  Row(
                    children: [
                      const Spacer(),
                      saveButton(),
                      cancelButton(context),
                    ],
                  )
                else
                  Row(
                    children: [
                      categoryDropdown(),
                      const Spacer(),
                      saveButton(),
                      cancelButton(context),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  ElevatedButton cancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Cancel"),
    );
  }

  ElevatedButton saveButton() {
    return ElevatedButton(
      onPressed: _submitExpense,
      child: const Text("Save"),
    );
  }

  DropdownButton<Category> categoryDropdown() {
    return DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: _setCategory,
    );
  }

  Row dateInputPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_selectedDate == null
            ? "No date selected"
            : dateFormatter.format(_selectedDate!)),
        IconButton(
            onPressed: _openDatePicker, icon: const Icon(Icons.calendar_month))
      ],
    );
  }

  bool isLandscaped(double maxWidth) => maxWidth > 600;

  TextField amountInputText() {
    return TextField(
      controller: _amountController,
      decoration: const InputDecoration(
        prefixText: "\$",
        label: Text("Amount"),
      ),
      keyboardType: TextInputType.number,
    );
  }

  TextField titleInputText() {
    return TextField(
      // onChanged: _saveTitle,
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text("Title"),
      ),
    );
  }
}
