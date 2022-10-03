import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTX;

  NewTransaction(this.newTX);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final achat = TextEditingController();
  final montant = TextEditingController();
  var _selectedDate;

  void submitData() {
    if (montant.text.isEmpty) {
      return;
    }
    final enteredAchat = achat.text;
    final enteredMontant = int.parse(montant.text);

    if (enteredAchat.isEmpty || enteredMontant <= 0 || _selectedDate == null) {
      return;
    }
    widget.newTX(enteredAchat, enteredMontant, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            controller: achat,
            onSubmitted: (_) => submitData(),
            // onChanged: ((value) => achat = value),
            decoration: const InputDecoration(labelText: 'Tu a achété quoi ?'),
          ),
          TextField(
            controller: montant,
            // onChanged: ((value) => montant = value),
            onSubmitted: (_) => submitData(),
            decoration: const InputDecoration(labelText: 'Le montant'),
            keyboardType: TextInputType.number,
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'Pas de date  ?'
                      : DateFormat.yMMMEd().format(_selectedDate)),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text(
                    'Choisissez une date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
              onPressed: submitData,
              child: const Text(
                "Compris",
                // style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ]),
      ),
    );
  }
}
