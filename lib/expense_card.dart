import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final String item;
  final int price;
  final DateTime date;
  final Function() delete;

  const ExpenseCard(
      {Key? key,
      required this.item,
      required this.price,
      required this.date,
      required this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              radius: 35,
              child: Text('₹' + price.toString()),
            ),
            title: Text(item),
            subtitle: Text(
              "${date.day}-${date.month}-${date.year}",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: IconButton(
              onPressed: delete,
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
