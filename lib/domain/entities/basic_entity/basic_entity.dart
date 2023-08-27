import 'package:equatable/equatable.dart';

class BasicEntity extends Equatable {
  final int? id;
  final String? name;
  final String? brand;
  final String? model;
  final String? key;
  final String? image;
  final String? icon;
  final String? value  ;

  const BasicEntity( {
    required this.id,
    required this.name,
    required this.key,
    required this.brand,
    required this.model,
    required this.image,
    required this.value ,
    required this.icon
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
    key,
    brand,
    model,
        image,
        value,
    icon
      ];
}
