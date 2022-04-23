import 'package:flutter/material.dart';
import '../core/app_images.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionsListWidget extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onRemove;

  const TransactionsListWidget(
    this.transactions,
    this.onRemove, {
    Key? key,
  }) : super(key: key);

  static const String _dollarSing = 'R\$';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                const Text('Nenhuma Transação Cadastrada'),
                const SizedBox(height: 20),
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      AppImages.waiting,
                      fit: BoxFit.contain,
                    )),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: _buildItem,
            ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final tr = transactions[index];
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.redAccent,
        child: const Align(
          alignment: Alignment(0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: ListTile(
          onTap: () => {DeletableChipAttributes},
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text(
                  _dollarSing + '${tr.value.toStringAsFixed(2)} ',
                  /* style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ), */
                ),
              ),
            ),
          ),
          title: Container(
            width: 500,
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                tr.title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 82, 82, 82),
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                ),
              ),
            ),
          ),
          subtitle: Text(
            DateFormat('d MMM y').format(tr.date),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          /* trailing: IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () {},
          ), */
        ),
      ),
      onDismissed: (direction) => onRemove(tr.id),
    );
  }
}



/* Widget _buildItem(BuildContext context, int index) {
    final tr = transactions[index];
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.redAccent,
        child: const Align(
          alignment: Alignment(0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: ListTile(
          onTap: () => {DeletableChipAttributes},
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text(
                  _dollarSing + '${tr.value}',
                  /* style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ), */
                ),
              ),
            ),
          ),
          title: Container(
            width: 500,
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                tr.title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 82, 82, 82),
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                ),
              ),
            ),
          ),
          subtitle: Text(
            DateFormat('d MMM y').format(tr.date),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          /* trailing: IconButton(
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: () {},
          ), */
        ),
      ),
      onDismissed: (direction) {},
    );
  } */





/*

(BuildContext context, int index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    onTap: () => {DeletableChipAttributes},
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            _dollarSing + '${tr.value}',
                            /* style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ), */
                          ),
                        ),
                      ),
                    ),
                    title: Container(
                      width: 500,
                      padding: EdgeInsets.zero,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          tr.title,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 82, 82, 82),
                            fontFamily: 'OpenSans',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => onRemove(tr.id),
                    ),
                  ),
                );
              },

 */

















/*

Card(
                  child: Container(
                    padding: EdgeInsets.zero,
                    width: 600,
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text(
                                _dollarSing + tr.value.toStringAsFixed(2),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          width: 194,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr.title,
                                  //style: Theme.of(context).textTheme.headline6,
                                  style: const TextStyle(
                                    color: Color.fromARGB(185, 82, 82, 82),
                                    fontFamily: 'OpenSans',
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMM y').format(tr.date),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

*/




















































/*

Card(
                  child: Container(
                    padding: EdgeInsets.zero,
                    width: 600,
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text(
                                _dollarSing + tr.value.toStringAsFixed(2),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          width: 194,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr.title,
                                  //style: Theme.of(context).textTheme.headline6,
                                  style: const TextStyle(
                                    color: Color.fromARGB(185, 82, 82, 82),
                                    fontFamily: 'OpenSans',
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMM y').format(tr.date),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

*/