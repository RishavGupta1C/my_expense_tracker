import 'package:flutter/material.dart';
import 'package:my_expense_tracker/models/expense.dart';
import 'package:my_expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.expenses,
    required this.onRemoveExpense,
  }) : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          margin: Theme.of(context).cardTheme.margin,
          // Change specific parameter using Theme
          // margin: EdgeInsets.symmetric(
          //   horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          // ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
