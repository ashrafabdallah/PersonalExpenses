import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function adTx;

  NewTransaction(this.adTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _dateTime;

  void _submitData() {
    if (titleController.text.isEmpty) {
      return;
    }
    final String title = titleController.text;
    final double amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || _dateTime == null) {
      return;
    }
    widget.adTx(title, amount, _dateTime);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateTime = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(label: Text("Title")),
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 4,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(label: Text("Amount")),
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_dateTime == null
                        ? 'No Date Chosen!'
                        : "Picked Date: ${DateFormat.yMd().format(_dateTime!)}"),
                  ),
                  TextButton(
                      onPressed: () => _presentDatePicker(),
                      child: Text(
                        "Choose Date",
                        style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _submitData(),
              child: Text(
                "Add Transaction",
                style: TextStyle(
                    color: Colors.white,
                   ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
