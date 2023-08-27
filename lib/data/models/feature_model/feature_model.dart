import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:automobile_project/domain/entities/feature_entity/feature_entity.dart';

class FeatureModel extends FeatureEntity {
  const FeatureModel({
    required super.id,
    required super.name,
    required super.options,
  });

  factory FeatureModel.fromJson(Map<String, dynamic>? json) {
    return FeatureModel(
      id: json?['id'],
      name: json?['name'],
      options: List<BasicModel>.from(json?['options'].map((e) => BasicModel.fromJson(e))),
    );
  }
}
