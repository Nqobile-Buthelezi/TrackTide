import 'package:flutter/material.dart';
import 'package:tracktide_app/widgets/transaction_list.dart';
import '../models/transaction.dart';
import '../services/transaction_service.dart';
import '../services/profiling_service.dart';
import 'transaction_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TransactionService _transactionService = TransactionService();
  final ProfilingService _profilingService = ProfilingService();

  String getUserProfile() {
    return _profilingService.getUserProfile(_transactionService.getAllTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'TrackTide',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {
              // Add settings or options here
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: TransactionList(
              transactions: _transactionService.getAllTransactions(),
              onEditTransaction: _handleEditTransaction,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'User Profile: ${getUserProfile()}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTransaction,
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, size: 28),
      ),
    );
  }

  void _handleEditTransaction(Transaction transaction) {
    setState(() {
      _transactionService.updateTransaction(transaction);
    });
  }

  void _addNewTransaction() {
    setState(() {
      final newTransaction = Transaction(
        id: DateTime.now().toString(),
        amount: 100.0,
        date: DateTime.now(),
      );
      _transactionService.addTransaction(newTransaction);
    });
  }
}
