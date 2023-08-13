class MovementCategoryDTO {
  final int id;
  final String name;
  final String details;

  MovementCategoryDTO({
    required this.id,
    required this.name,
    required this.details,
  });

  factory MovementCategoryDTO.fromJson(Map<String, dynamic> json) {
    return MovementCategoryDTO(
      id: json['id'],
      name: json['name'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'details': details,
      };
}
