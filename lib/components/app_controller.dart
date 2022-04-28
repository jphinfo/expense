import 'package:flutter/widgets.dart';

class AppControllerWidget extends ChangeNotifier {
  static final instance = AppControllerWidget();

  bool _showChart = false;
  changeChart() {
    _showChart = !_showChart;
    notifyListeners();
  }

  get isAppChangeChart {
    return _showChart;
  }
}
