class FinanceCarModel {
  int? id;
  String? name;
  String? image;

  FinanceCarModel({this.id, this.name, this.image});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory FinanceCarModel.fromMap(Map<String, dynamic> map) {
    return FinanceCarModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}