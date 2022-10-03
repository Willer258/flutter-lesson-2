// package de base
import 'package:flutter/material.dart';

//Models pour dire les varibles strucuter par des classes
import 'models/transaction.dart';

//les widgets
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // pour disable le ruban debug
      theme: ThemeData(
          //Gesion de theme pour l'application

          primarySwatch: Colors.red,
          accentColor: Colors.amberAccent,
          fontFamily: 'Averta',
          appBarTheme: AppBarTheme(
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                      titleLarge: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))
                  .headline6)),
      title: 'Mes depenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];

  //Fonction permettant de creer une transaction
  void _addNewTransaction(String txBuyed, int txAmount, DateTime date) {
    //En fonction des parametre on definis les nouveau objet qui vont s'effectuer
    final newTx = Transaction(
        title: txBuyed,
        amount: txAmount,
        date: date,
        id: DateTime.now().toString());

// le setstate est la pour faire rerendre le widgets pour changer les donnees pour que l'utilisateur voie
    setState(() {
      _userTransaction.add(newTx);
    });
  }

//Modal permettant la creaction d'une transaction
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(
                  _addNewTransaction)); //New transation est le formulaire constituant les element pour pouvoir creer ta transaction
        });
  }

//delete the transaction
  void _deleteTransaction(String id) {
    setState(() {
      //removeWher un pain beni qui permet de suprrimer un element a partire de son id
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  // ignore: unused_element
  List<Transaction> get _recentTransactions {
    //normalement cette foction permet de recuperer les transactions
    return _userTransaction
        .where((element) => element.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes depenses'),
        actions: <Widget>[
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransaction, _deleteTransaction)
            ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
