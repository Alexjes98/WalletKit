class DebtDTO {
  final int id;
  final double amount;
  final double coveredAmount;
  final int from;
  final String fromName;
  final int to;
  final String toName;
  final String description;
  final DateTime date;

  DebtDTO(
      {required this.id,
      required this.amount,
      required this.coveredAmount,
      required this.from,
      required this.fromName,
      required this.to,
      required this.toName,
      required this.description,
      required this.date});

  factory DebtDTO.fromJson(Map<String, dynamic> json) {
    return DebtDTO(
      id: json['id'],
      amount: json['amount'].toDouble(),
      coveredAmount: json['coveredAmount'].toDouble(),
      from: json['from'],
      fromName: json['fromName'],
      to: json['to'],
      toName: json['toName'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'coveredAmount': coveredAmount,
      'from': from,
      'fromName': fromName,
      'to': to,
      'toName': toName,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}
