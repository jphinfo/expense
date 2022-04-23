import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class ChartWidget extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const ChartWidget(
    this.recentTransaction, {
    Key? key,
  }) : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weeDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weeDay.day;
        bool sameMonth = recentTransaction[i].date.month == weeDay.month;
        bool sameYear = recentTransaction[i].date.year == weeDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weeDay),
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
        0.0, (sum, tr) => sum + (tr['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions
                .map(
                  (tr) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBarWidget(
                      label: tr['day'].toString(),
                      value: (tr['value'] as double),
                      percentage: _weekTotalValue == 0.0
                          ? 0.0
                          : (tr['value'] as double) / _weekTotalValue,
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
