class MovementDTO {
  final int id;
  final int userId;
  final String transaction_type;
  final String description;
  final String? source;
  final double amount;
  final String movement_category;
  final int? debtId;
  final DateTime date;

  MovementDTO({
    required this.id,
    required this.userId,
    required this.transaction_type,
    required this.description,
    this.source,
    required this.amount,
    required this.movement_category,
    this.debtId,
    required this.date,
  });

  factory MovementDTO.fromJson(Map<String, dynamic> json) {
    return MovementDTO(
      id: json['id'],
      userId: json['userId'],
      transaction_type: json['transaction_type'],
      description: json['description'],
      source: json['source'],
      amount: json['amount'].toDouble(),
      movement_category: json['movement_category'],
      debtId: json['debtId'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'transaction_type': transaction_type,
      'description': description,
      'source': source,
      'amount': amount,
      'movement_category': movement_category,
      'debtId': debtId,
      'date': date.toIso8601String(),
    };
  }
}
