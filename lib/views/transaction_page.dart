import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/transaction_service.dart';
import '../widgets/transaction_list.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TransactionService _transactionService = TransactionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: TransactionList(
        transactions: _transactionService.getAllTransactions(),
        onEditTransaction: _editTransaction,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTransaction,
        child: Icon(Icons.add),
        tooltip: 'Add new transaction',
      ),
    );
  }

  void _editTransaction(Transaction transaction) async {
    final editedTransaction = await showDialog<Transaction>(
      context: context,
      builder: (BuildContext context) => _buildTransactionDialog(transaction),
    );

    if (editedTransaction != null) {
      setState(() {
        _transactionService.updateTransaction(editedTransaction);
      });
    }
  }

  void _addNewTransaction() async {
    final newTransaction = await showDialog<Transaction>(
      context: context,
      builder: (BuildContext context) => _buildTransactionDialog(null),
    );

    if (newTransaction != null) {
      setState(() {
        _transactionService.addTransaction(newTransaction);
      });
    }
  }

  Widget _buildTransactionDialog(Transaction? transaction) {
    final isEditing = transaction != null;
    final titleController = TextEditingController(text: transaction?.description ?? '');
    final amountController = TextEditingController(text: transaction?.amount.toString() ?? '');

    return AlertDialog(
      title: Text(isEditing ? 'Edit Transaction' : 'Add Transaction'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: amountController,
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final description = titleController.text;
            final amount = double.tryParse(amountController.text) ?? 0.0;
            final updatedTransaction = Transaction(
              id: transaction?.id ?? DateTime.now().toString(),
              amount: amount,
              date: transaction?.date ?? DateTime.now(),
              description: description,
            );
            Navigator.of(context).pop(updatedTransaction);
          },
          child: Text(isEditing ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
