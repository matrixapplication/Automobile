class EndUserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? token;
  String? image;

  EndUserModel(
      {this.id, this.name, this.email, this.phone, this.role, this.token , this.image});

  EndUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    token = json['token'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['token'] = token;
    data['image'] = image;
    return data;
  }
}
