class PersonDTO {
  final int id;
  final String name;
  final String description;

  PersonDTO({
    required this.id,
    required this.name,
    required this.description,
  });

  factory PersonDTO.fromJson(Map<String, dynamic> json) {
    return PersonDTO(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}
