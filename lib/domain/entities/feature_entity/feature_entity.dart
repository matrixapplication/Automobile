import 'package:automobile_project/data/models/basic_model/basic_model.dart';
import 'package:equatable/equatable.dart';

class FeatureEntity extends Equatable {
  final int? id;
  final String? name;
  final List<BasicModel>? options;

  const FeatureEntity({
    required this.id,
    required this.name,
    required this.options,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        options,
      ];
}
