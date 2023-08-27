import '../../../domain/entities/show_room_branch_entity/show_room_branch_entity.dart';

class ShowRoomBranchModel extends ShowRoomBranchEntity {
  const ShowRoomBranchModel({
    required super.id,
    required super.name,
    required super.address,
    required super.city,
    required super.district,
    required super.phone,
    required super.whatsapp,
    required super.cityId,
    required super.districtId,

  });

  factory ShowRoomBranchModel.fromJson(Map<String, dynamic>? json) {
    return ShowRoomBranchModel(
      id: json?['id'],
      name: json?['name'],
      address: json?['address'],
      city: json?['city'],
      district: json?['district'],
      phone: json?['phone'],
      whatsapp: json?['whatsapp'],
      cityId: json?['cityId'].toString(),
      districtId: json?['districtId'].toString(),
    );
  }
}
