import 'package:flutter/material.dart';

class MovementCategoryDTO {
  final int id;
  final String name;
  final String details;
  final IconData icon;

  MovementCategoryDTO({
    required this.id,
    required this.name,
    required this.details,
    required this.icon,
  });

  factory MovementCategoryDTO.fromJson(Map<String, dynamic> json) {
    return MovementCategoryDTO(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'details': details,
        'icon': icon.codePoint,
      };
}
