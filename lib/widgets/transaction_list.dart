import 'package:flutter/material.dart';
import '../models/transaction.dart';

/// A widget that displays a list of transactions and allows editing of each transaction.
class TransactionList extends StatelessWidget {
  /// The list of transactions to display.
  final List<Transaction> transactions;

  /// Callback function to be called when a transaction is edited.
  final Function(Transaction) onEditTransaction;

  /// Creates a [TransactionList] widget.
  ///
  /// The [transactions] parameter is required and should contain the list of
  /// transactions to display.
  ///
  /// The [onEditTransaction] parameter is required and should be a function
  /// that handles updating a transaction when it's edited.
  TransactionList({
    required this.transactions,
    required this.onEditTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text('\$${transaction.amount.toStringAsFixed(2)}'),
          subtitle: Text(transaction.description ?? 'No description added'),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context, transaction);
            },
          ),
        );
      },
    );
  }

  /// Shows a dialog to edit the description of a transaction.
  ///
  /// This method creates and shows an [AlertDialog] with a text field
  /// pre-filled with the current transaction description. The user can
  /// modify the description and save the changes.
  ///
  /// Parameters:
  ///   [context] - The build context, used to show the dialog and to pop
  ///               the navigation stack when the dialog is dismissed.
  ///   [transaction] - The transaction being edited.
  void _showEditDialog(BuildContext context, Transaction transaction) {
    final TextEditingController _descriptionController =
        TextEditingController(text: transaction.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Transaction'),
          content: TextField(
            controller: _descriptionController,
            decoration: InputDecoration(hintText: "Enter new description"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final newDescription = _descriptionController.text;
                transaction.addContext(newDescription);
                onEditTransaction(transaction);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
