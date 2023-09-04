import 'package:uuid/uuid.dart';

// Unique Id Generation
const uuid = Uuid();

enum Category { food, travel, leisure, work }

class Expense {
  // For more than two parameters in a function
  //it's better to use named parameters
  // so that it will be easier to target the parameters by name
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
