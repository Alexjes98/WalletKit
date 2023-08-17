class BalanceDTO {
  final String generalBalance;
  final String generalIncome;
  final String generalExpenses;
  final String monthBalance;
  final String monthIncome;
  final String monthExpenses;

  BalanceDTO({
    required this.generalBalance,
    required this.generalIncome,
    required this.generalExpenses,
    required this.monthBalance,
    required this.monthIncome,
    required this.monthExpenses,
  });

  factory BalanceDTO.fromJson(Map<String, dynamic> json) {
    return BalanceDTO(
      generalBalance: json['generalBalance'],
      generalIncome: json['generalIncome'],
      generalExpenses: json['generalExpenses'],
      monthBalance: json['monthBalance'],
      monthIncome: json['monthIncome'],
      monthExpenses: json['monthExpenses'],
    );
  }

  Map<String, dynamic> toJson() => {
        'generalBalance': generalBalance,
        'generalIncome': generalIncome,
        'generalExpenses': generalExpenses,
        'monthBalance': monthBalance,
        'monthIncome': monthIncome,
        'monthExpenses': monthExpenses,
      };
}
