import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function removeTransaction;
  TransactionList(this.transactions, this.removeTransaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'Rien achété',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 150,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(
                            child: Column(
                          children: [
                            Text('${transactions[index].amount}'),
                            const    Text('Francs CFA')
                          ],
                        )),
                      ),
                    ),
                    title: Text(transactions[index].title),
                    subtitle: Text(
                        DateFormat.yMMMEd().format(transactions[index].date)),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            removeTransaction(transactions[index].id)),
                  ),
                ),
                itemCount: transactions.length,
              ));
  }
}
