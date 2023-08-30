class Notifications {
  int? id;
  String? title;
  String? message;
  String? type;
  int? carId;

  Notifications({this.id, this.title, this.message, this.type, this.carId});

  Notifications.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    title = json?['title'];
    message = json?['message'];
    type = json?['type'];
    carId = json?['car_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['type'] = type;
    data['car_id'] = carId;
    return data;
  }
}
