class TrackRequestModel {
  String? name;
  String? phone;
  String? isApproved;

  TrackRequestModel({this.name, this.phone, this.isApproved});

  TrackRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    isApproved = json['is_approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['is_approved'] = isApproved;
    return data;
  }
}
