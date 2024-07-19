class TransactionModel {
  final int id;
  final String? content;
  final DateTime dateTransaction;
  final double amount;
  final int status;
  final String paymethod;
  final int walletId;
  final int depositId;

  TransactionModel({
    required this.id,
    this.content,
    required this.dateTransaction,
    required this.amount,
    required this.status,
    required this.paymethod,
    required this.walletId,
    required this.depositId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      content: json['content'],
      dateTransaction: DateTime.parse(json['dateTransaction']),
      amount: json['amount'].toDouble(),
      status: json['status'],
      paymethod: json['paymethod'],
      walletId: json['walletId'],
      depositId: json['depositId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'dateTransaction': dateTransaction.toIso8601String(),
        'amount': amount,
        'status': status,
        'paymethod': paymethod,
        'walletId': walletId,
        'depositId': depositId,
      };
}
