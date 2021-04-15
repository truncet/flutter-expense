import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTx;

  TransactionList(this.userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transaction added!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'asset/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                        child: Text('\$${userTransactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    '${userTransactions[index].title}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd()
                        .format(userTransactions[index].date)
                        .toString(),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? TextButton.icon(
                          onPressed: () {
                            deleteTx(userTransactions[index].id);
                          },
                          icon: Icon(Icons.delete),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deleteTx(userTransactions[index].id);
                          },
                        ),
                ),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
