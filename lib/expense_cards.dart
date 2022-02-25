import 'package:flutter/material.dart';
import 'package:personal_expenses/expense_card.dart';

class ExpenseCardsSortList extends StatefulWidget {
  final Map<String, Map<String, dynamic>> expense;
  final String sortBy;
  const ExpenseCardsSortList(
      {Key? key, required this.expense, required this.sortBy})
      : super(key: key);

  @override
  State<ExpenseCardsSortList> createState() => _ExpenseCardsSortListState();
}

class _ExpenseCardsSortListState extends State<ExpenseCardsSortList> {
  List<String> getSortedList() {
    if (widget.sortBy == 'name') {
      return widget.expense.keys.toList()..sort();
    } else if (widget.sortBy == 'entry') {
      return widget.expense.keys.toList();
    } else {
      return widget.expense.keys.toList()
        ..sort((k1, k2) => ((widget.expense[k1]!)[widget.sortBy])
            .compareTo((widget.expense[k2]!)[widget.sortBy]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: (getSortedList()).map((String key) {
      return ExpenseCard(
        item: key,
        price: (widget.expense[key]!)['price'],
        date: (widget.expense[key]!)['date'],
        delete: () {
          setState(() {
            widget.expense.remove(key);
          });
        },
      );
    }).toList());
  }
}
