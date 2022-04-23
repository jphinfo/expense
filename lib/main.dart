import 'package:flutter/material.dart';
import '../components/chart.dart';
import './models/transaction.dart';
import './core/app_colors.dart';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import 'dart:math';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      appBarTheme: AppBarTheme(
        titleTextStyle: ThemeData.light()
            .textTheme
            .copyWith(
                headline6: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.w700))
            .headline6,
      ),
    );

    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: AppColors.darkColor,
          secondary: AppColors.ligthColor,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String _title = 'Despesas Pessoais';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [
    Transaction(
      id: 't0',
      title: 'Novo Tênis',
      value: 310.87,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't1',
      title: 'Monitor Gamer AOC agon 31,5"',
      value: 180.70,
      date: DateTime.now().subtract(const Duration(days: 0)),
    ),
    Transaction(
      id: 't3',
      title: 'Teclado',
      value: 110.70,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transaction
        .where((tr) =>
            tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transaction.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionFormWidget(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(MyHomePage._title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChartWidget(_recentTransactions),
            TransactionsListWidget(_transaction, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      /*  bottomNavigationBar: BottomAppBar(
        color: AppColors.darkColor,
        child: Container(height: 35),
      ), */
    );
  }
}
