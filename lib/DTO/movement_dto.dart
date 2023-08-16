class MovementDTO {
  final int id;
  final int userId;
  final String transactionType;
  final String description;
  final String? source;
  final double amount;
  final int movementCategory;
  final int? debtId;
  final DateTime date;
  final DateTime createdAt = DateTime.now();

  MovementDTO({
    required this.id,
    required this.userId,
    required this.transactionType,
    required this.description,
    this.source,
    required this.amount,
    required this.movementCategory,
    this.debtId,
    required this.date,
  });

  factory MovementDTO.fromJson(Map<String, dynamic> json) {
    return MovementDTO(
      id: json['id'],
      userId: json['userId'],
      transactionType: json['transaction_type'],
      description: json['description'],
      source: json['source'],
      amount: json['amount'].toDouble(),
      movementCategory: json['movement_category'],
      debtId: json['debtId'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'transaction_type': transactionType,
      'description': description,
      'source': source,
      'amount': amount,
      'movement_category': movementCategory,
      'debtId': debtId,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
