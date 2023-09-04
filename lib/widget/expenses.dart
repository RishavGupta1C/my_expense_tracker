import 'package:flutter/material.dart';
import 'package:my_expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:my_expense_tracker/models/expense.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(' The chart'),
          // As ListView is present inside this Column Widget
          // Expanded is used to resolve this ambiguity of size
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
