import 'package:automobile_project/domain/entities/basic_entity/basic_entity.dart';

class BasicModel extends BasicEntity {
  const BasicModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.key,
    required super.image,
    required super.model,
    required super.value,
    required super.icon
  });

  factory BasicModel.fromJson(Map<String, dynamic>? json) {
    return BasicModel(
      id: json?['id'],
      name: json?['name'],
      brand: json?['brand'],
      key: json?['key'],
      model: json?['model'],
      image: json?['image'],
      value: json?['value'],
      icon: json?['icon']
    );
  }
}
