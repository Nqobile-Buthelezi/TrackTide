import '../models/transaction.dart';

/// Service class for managing transactions.
///
/// This class provides methods for adding, updating, and categorizing transactions.
class TransactionService {
  /// List of all transactions managed by this service.
  final List<Transaction> transactions = [];

  /// Adds a new transaction to the list.
  ///
  /// [transaction] The transaction to be added.
  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
  }

  /// Adds context (description) to an existing transaction.
  ///
  /// [transactionId] The ID of the transaction to update.
  /// [context] The context (description) to be added.
  ///
  /// Throws a [StateError] if no transaction is found with the given ID.
  void addContextToTransaction(String transactionId, String context) {
    final transaction = transactions.firstWhere(
      (t) => t.id == transactionId,
      orElse: () =>
          throw StateError('No transaction found with ID: $transactionId'),
    );
    transaction.addContext(context);
  }

  /// Categorizes a transaction based on its description.
  ///
  /// This method currently only categorizes 'Taxi Fare' as 'Transport'.
  /// It can be expanded to include more categorization logic.
  ///
  /// [transaction] The transaction to be categorized.
  void categorizeTransaction(Transaction transaction) {
    if (transaction.description?.toLowerCase() == 'taxi fare') {
      transaction.category = 'Transport';
    }
    // Additional categorization logic can be added here
  }

  /// Retrieves all transactions.
  ///
  /// Returns a list of all transactions.
  List<Transaction> getAllTransactions() {
    return List.unmodifiable(transactions);
  }

  /// Finds a transaction by its ID.
  ///
  /// [id] The ID of the transaction to find.
  ///
  /// Returns the found transaction or null if not found.
  Transaction? getTransactionById(String id) {
    try {
      return transactions.firstWhere((t) => t.id == id);
    } on StateError {
      return null;
    }
  }

  /// Removes a transaction from the list.
  ///
  /// [transaction] The transaction to be removed.
  ///
  /// Returns true if the transaction was successfully removed, false otherwise.
  bool removeTransaction(Transaction transaction) {
    return transactions.remove(transaction);
  }

  /// Updates a transaction from the list
  /// 
  /// [updatedTransaction] the transaction to be updated
  void updateTransaction(Transaction updatedTransaction) {
  final index = transactions.indexWhere((t) => t.id == updatedTransaction.id);
  if (index != -1) {
    transactions[index] = updatedTransaction;
  }
}

}
