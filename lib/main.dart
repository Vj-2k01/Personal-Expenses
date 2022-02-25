import 'package:flutter/material.dart';
import 'package:personal_expenses/expense_cards.dart';

void main() {
  runApp(const PersonalExpenses());
}

class PersonalExpenses extends StatefulWidget {
  const PersonalExpenses({Key? key}) : super(key: key);

  @override
  _PersonalExpensesState createState() => _PersonalExpensesState();
}

enum SortBy { date, entry, name, price }
bool _show = false;
bool isDateChoosen = false;
bool isTransactionAdded = false;
dynamic _dateTime;
bool isValidateTitle = false;
bool isValidateAmount = false;
bool isDateSelected = true;
bool isDuplicateChecker = false;

class _PersonalExpensesState extends State<PersonalExpenses> {
  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();

  var expense = {
    'books': {'price': 100, 'date': DateTime(2022, 2, 12)},
    'phone': {'price': 8000, 'date': DateTime(2022, 2, 12)},
    'laptop': {'price': 20000, 'date': DateTime(2022, 2, 14)},
    'mouse': {'price': 200, 'date': DateTime(2022, 2, 13)},
    // 'note': {'price': 80, 'date': DateTime(2019, 2, 12)},
    // 'pen': {'price': 20, 'date': DateTime(2022, 2, 13)},
    // 'bag': {'price': 2000, 'date': DateTime(2022, 2, 16)},
    // 'pencilbox': {'price': 20, 'date': DateTime(2022, 2, 11)},
    // 'calculator': {'price': 200, 'date': DateTime(2022, 2, 16)},
    // 'computer': {'price': 20000, 'date': DateTime(2022, 2, 13)},
    // 'keyboard': {'price': 1000, 'date': DateTime(2022, 2, 19)}
  };

  //SortBy sortBy = SortBy.date;
  var sortBy = 'entry';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SizedBox(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text('Personal Expenses'),
            actions: [
              DropdownButton<String>(
                value: sortBy,
                iconEnabledColor: Colors.white,
                items: <String>{'entry', 'date', 'price', 'name'}
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    sortBy = value!;
                  });
                },
                dropdownColor: Colors.purpleAccent,
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _show = true;
                  setState(() {});
                },
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () {
              setState(() {
                _show = false;
              });
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    const Card(
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Padding(
                        padding: EdgeInsets.all(35.0),
                        child: SizedBox(
                          width: 300,
                          height: 90,
                          child: Text('graph'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        isAlwaysShown: false,
                        showTrackOnHover: true,
                        thickness: 7.0,
                        child: SingleChildScrollView(
                          child: ExpenseCardsSortList(
                              expense: expense, sortBy: sortBy),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FloatingActionButton(
                      onPressed: () {
                        _show = true;
                        setState(() {});
                      },
                      child: const Icon(Icons.add),
                      backgroundColor: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomSheet: _showBottomSheet(),
        ),
      ),
    );
  }

  Widget? _showBottomSheet() {
    if (_show) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _show = false;
                        });
                      },
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  ),
                  TextField(
                    controller: title,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: const TextStyle(color: Colors.black),
                      errorText: isValidateTitle ? 'Title is required' : null,
                    ),
                  ),
                  Text(
                    isDuplicateChecker ? 'Already name taken' : '',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: amount,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: const TextStyle(color: Colors.black),
                      errorText: isValidateAmount ? 'Amount is required' : null,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_dateTime == null
                          ? 'No date Choosen!'
                          : _dateTime.toString()),
                      TextButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2201))
                              .then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                        child: const Text(
                          'Choose Date',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    isDateSelected == false ? 'Date is mandatory!' : '',
                    style: const TextStyle(color: Colors.red),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        onPressed: () {
                          setState(() {
                            title.text.isEmpty
                                ? isValidateTitle = true
                                : isValidateTitle = false;
                            amount.text.isEmpty
                                ? isValidateAmount = true
                                : isValidateAmount = false;
                            _dateTime == null
                                ? isDateSelected = false
                                : isDateSelected = true;
                            expense.containsKey(title.text.toLowerCase())
                                ? isDuplicateChecker = true
                                : isDuplicateChecker = false;
                          });

                          if (isValidateAmount == false &&
                              isValidateTitle == false &&
                              isDateSelected == true &&
                              isDuplicateChecker == false) {
                            expense[title.text.toLowerCase()] = {
                              'price': int.parse(amount.text),
                              'date': _dateTime,
                            };
                            title.clear();
                            amount.clear();
                            _dateTime = null;

                            setState(() {
                              isTransactionAdded = !isTransactionAdded;
                            });

                            Future.delayed(const Duration(seconds: 3), () {
                              setState(() {
                                isTransactionAdded = !isTransactionAdded;
                                _show = false;
                              });
                            });
                          }
                        },
                        icon: Icon(isTransactionAdded == true
                            ? Icons.check
                            : Icons.add),
                        label: Text(isTransactionAdded == true
                            ? 'Added Successfully'
                            : 'Add Transaction'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return null;
    }
  }
}
