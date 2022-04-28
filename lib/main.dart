import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './core/app_colors.dart';
import '../components/chart.dart';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import './components/app_controller.dart';

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
      id: 't1',
      title: 'Novo Tênis',
      value: 310.87,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't2',
      title: 'Monitor Gamer AOC agon 31,5"',
      value: 180.70,
      date: DateTime.now().subtract(const Duration(days: 0)),
    ),
    Transaction(
      id: 't3',
      title: 'Teclado',
      value: 110.70,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't4',
      title: 'Smarth Phone',
      value: 963.59,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't5',
      title: 'Cinema',
      value: 65.20,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't6',
      title: 'Lanche',
      value: 15.90,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't7',
      title: 'Almoço',
      value: 20.70,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't8',
      title: 'Manuteção da Moto',
      value: 365.70,
      date: DateTime.now().subtract(const Duration(days: 6)),
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

  bool _showChart = false;

  _removeTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TransactionFormWidget(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = [
      // Aptando icone do chart p/ o IOS
      if (_isLandscape)
        _getIconButton(
          AppControllerWidget.instance.isAppChangeChart
              ? Icons.list
              : Icons.bar_chart,
          () {
            AppControllerWidget.instance.isAppChangeChart;
            setState(() {
              AppControllerWidget.instance.changeChart();
            });
          },
        ),
      _getIconButton(
        Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    /* final actions = [    // Aptando icone do chart p/ o IOS
      if (_isLandscape)
        _getIconButton(
          _showChart ? Icons.list : Icons.show_chart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ]; */

    final appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text(MyHomePage._title),
      actions: actions,
    );

    final availabelHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                /* children: [
                  const Text('Exibir Gráfico'),
                  Switch.adaptive(  // Aptando o butão para a plataforma IOS
                    activeColor: Theme.of(context).backgroundColor,
                    value: AppControllerWidget.instance.isAppChangeChart,
                    onChanged: (value) {
                      setState(() {
                        AppControllerWidget.instance.changeChart();
                      });
                    },
                  ),
                ], */
              ),
            if (AppControllerWidget.instance.isAppChangeChart || !_isLandscape)
              Container(
                padding: EdgeInsets.zero,
                child: ChartWidget(_recentTransactions),
                height: availabelHeight * (_isLandscape ? 0.65 : 0.3),
              ),
            if (!AppControllerWidget.instance.isAppChangeChart || !_isLandscape)
              Container(
                padding: EdgeInsets.zero,
                child: TransactionsListWidget(_transaction, _removeTransaction),
                height: availabelHeight * (_isLandscape ? 0.95 : 0.66),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS // Aptando o Scaffold p/ plataform IOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton:
                Platform.isIOS // Aptando esse widget p/ a plataforma IOS
                    ? Container()
                    : FloatingActionButton(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Icon(
                          Icons.add,
                        ),
                        onPressed: () => _openTransactionFormModal(context),
                      ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndDocked,
            /*  bottomNavigationBar: BottomAppBar(
        color: AppColors.darkColor,
        child: Container(height: 35),
      ), */
          );
  }
}
