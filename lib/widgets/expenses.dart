import 'package:flutter/material.dart';
import 'package:my_expense_tracker/widgets/chart/chart.dart';
import 'package:my_expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:my_expense_tracker/models/expense.dart';
import 'package:my_expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Plane Tickets',
      amount: 1200.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Restaurant Bill',
      amount: 150.29,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _openAddExpenseOverlay() {
    // context object is automatically created inside State class
    // ctx is context of modalBottomSheet
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    // REMOVE PREVIOUS UNDO AFTER SIMULTANEOUS DELETION
    ScaffoldMessenger.of(context).clearSnackBars();

    // UNDO DELETED EXPENSE
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses Found, Start Adding Some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          // As ListView is present inside this Column Widget
          // Expanded is used to resolve this ambiguity of size
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
