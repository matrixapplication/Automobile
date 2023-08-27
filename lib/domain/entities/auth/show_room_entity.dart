import 'package:equatable/equatable.dart';

class ShowRoomEntity extends Equatable {
  final int? id;
  final String? ownerName;
  final String? showroomName;
  final String? description;
  final String? code;
  final String? phone;
  final String? whatsapp;
  final String? endTaxCard;
  final String? role;
  final String? address;
  final bool? isBlocked;
  final String? token;
  final String? image;
  final String? coverImage;
  final String? carCount ;

  const ShowRoomEntity( {
    required this.id,
    required this.ownerName,
    required this.showroomName,
    required this.description,
    required this.code,
    required this.phone,
    required this.whatsapp,
    required this.endTaxCard,
    required this.role,
    required this.address,
    required this.isBlocked,
    required this.token,
    required this.image ,
    required this.carCount ,
    required this.coverImage
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        ownerName,
        showroomName,
        description,
        code,
        phone,
        whatsapp,
        endTaxCard,
        role,
        address,
        isBlocked,
        token,
    image ,
    coverImage , carCount
      ];
}
