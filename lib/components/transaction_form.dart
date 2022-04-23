import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime _selectedDate = DateTime.now();

  _subimitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final date = _selectedDate;

    if (title.isEmpty || value <= 0 || date == null) {
      return;
    }

    widget.onSubimit(title, value, date);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: _valueController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                //onSubmitted: (value) => _subimitForm(), => Inseri a despesa após confirmar o valor
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data selectionada: ' +
                                DateFormat('dd/MM/y').format(_selectedDate),
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _subimitForm,
                    child: const Text(
                      'Nova Transação',
                      //style: TextStyle(color: AppColors.darkColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
