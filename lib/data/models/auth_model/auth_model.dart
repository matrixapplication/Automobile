import '../../../domain/entities/auth/show_room_entity.dart';

class ShowRoomModel extends ShowRoomEntity {
  const ShowRoomModel({
    required super.id,
    required super.ownerName,
    required super.showroomName,
    required super.description,
    required super.code,
    required super.phone,
    required super.whatsapp,
    required super.endTaxCard,
    required super.role,
    required super.address,
    required super.isBlocked,
    required super.token, required super.image, required super.coverImage, required super.carCount,
  });

  factory ShowRoomModel.fromJson(Map<String, dynamic>? json) {
    return ShowRoomModel(
      id: json?['id'],
      ownerName: json?['owner_name'],
      showroomName: json?['showroom_name'],
      description: json?['description'],
      code: json?['code'],
      phone: json?['phone'],
      whatsapp: json?['whatsapp'],
      endTaxCard: json?['end_tax_card'],
      role: json?['role'],
      address: json?['address'],
      isBlocked: json?['is_blocked'],
      token: json?['token'],
      image: json?['image'],
      coverImage: json?['cover_image'], carCount: json?['count_cars'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['owner_name'] = ownerName;
    data['showroom_name'] = showroomName;
    data['description'] = description;
    data['code'] = code;
    data['phone'] = phone;
    data['whatsapp'] = whatsapp;
    data['end_tax_card'] = endTaxCard;
    data['role'] = role;
    data['address'] = address;
    data['is_blocked'] = isBlocked;
    data['token'] = role;
    data['token'] = token;
    data['image'] = image;
    data['cover_image'] = coverImage;
    data['count_cars'] = carCount;

    return data;
  }
}
