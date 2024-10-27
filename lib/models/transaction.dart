import 'package:uuid/uuid.dart';

class Transaction {
  final String id;
  final double amount;
  final DateTime date;
  String? description;
  String? category;
  String? paymentMethod;
  bool isIncome;
  String? recipient;
  String? currency;
  String? attachmentUrl;
  List<String> tags;

  Transaction({
    String? id,
    required this.amount,
    required this.date,
    this.description,
    this.category,
    this.paymentMethod,
    this.isIncome = false,
    this.recipient,
    this.currency = 'USD',
    this.attachmentUrl,
    List<String>? tags,
  }) : id = id ?? Uuid().v4(),
       tags = tags ?? [];

  void addContext(String context) {
    this.description = context;
  }

  void addTag(String tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  double get absoluteAmount => isIncome ? amount : -amount;

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      category: map['category'],
      paymentMethod: map['paymentMethod'],
      isIncome: map['isIncome'] ?? false,
      recipient: map['recipient'],
      currency: map['currency'],
      attachmentUrl: map['attachmentUrl'],
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'category': category,
      'paymentMethod': paymentMethod,
      'isIncome': isIncome,
      'recipient': recipient,
      'currency': currency,
      'attachmentUrl': attachmentUrl,
      'tags': tags,
    };
  }
}
