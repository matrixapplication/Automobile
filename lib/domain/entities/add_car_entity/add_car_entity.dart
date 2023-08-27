import 'dart:io';

import 'package:equatable/equatable.dart';

class SellCarEntity extends Equatable {
  final int? modelId;
  final String? modelRole;
  final int? brandId;
  final int? carModelId;
  final int? carModelExtensionId;
  final int? branchId;
  final int? year;
  final String? color;
  final String? driveType;
  final int? bodyType;
  final String? fuelType;
  final String? status;
  final int? price;
  final int? doors;
  final int? engine;
  final int? cylinders;
  final int? mileage;
  final String? description;
  final List<File>? images;
  final List<int>? selectedOptions;


  const SellCarEntity( {

    required this.modelId,
    required this.modelRole,
    required this.brandId,
    required this.carModelId,
    required this.carModelExtensionId,
    required this.branchId,
    required this.year,
    required this.color,
    required this.driveType,
    required this.bodyType,
    required this.fuelType,
    required this.status,
    required this.price,
    required this.doors,
    required this.engine,
    required this.cylinders,
    required this.mileage,
    required this.description,
    required this.images,
    required this.selectedOptions,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        modelId,
        modelRole,
        brandId,
        carModelId,
        carModelExtensionId,
        branchId,
        year,
        color,
        driveType,
        bodyType,
        fuelType,
        status,
        price,
        doors,
        engine,
        cylinders,
        mileage,
        description,
        images,
    selectedOptions,

      ];
}
