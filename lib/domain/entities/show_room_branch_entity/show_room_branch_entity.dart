import 'package:equatable/equatable.dart';

class ShowRoomBranchEntity extends Equatable {
  final int? id;
  final String? name;
  final String? city;
  final String? district;
  final String? address;
  final String? phone;
  final String? whatsapp;
  final String? cityId;
  final  String? districtId;

  const ShowRoomBranchEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.district,
    required this.phone ,
    required this.whatsapp ,
    required this.cityId ,
    required this.districtId ,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        address,
        city,
        district,
        phone,
        whatsapp,
        cityId,
        districtId,
      ];
}
