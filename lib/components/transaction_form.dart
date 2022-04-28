import 'package:flutter/material.dart';
import '../components/adaptative_buttun.dart';

import 'adaptative_textfield.dart';
import 'adaptative_date_picker.dart';

class TransactionFormWidget extends StatefulWidget {
  const TransactionFormWidget(
    this.onSubimit, {
    Key? key,
  }) : super(key: key);

  final Function(String, double, DateTime) onSubimit;

  @override
  State<TransactionFormWidget> createState() => _TransactionFormWidgetState();
}

class _TransactionFormWidgetState extends State<TransactionFormWidget> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _subimitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final date = _selectedDate;

    if (title.isEmpty || value <= 0 || date == null) {
      return;
    }

    widget.onSubimit(title, value, date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AdaptativeTextField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              label: 'Título',
            ),
            AdaptativeTextField(
              controller: _valueController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              //onSubmitted: (value) => _subimitForm(), => Inseri a despesa após confirmar o valor
              label: 'Valor (R\$)',
            ),
            AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                ),
                AdaptativeButton(
                  label: 'Noba Transação',
                  onPressed: _subimitForm,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
