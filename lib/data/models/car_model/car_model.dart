class CarModel {
  int? id;
  String? modelRole;
  ModelObject? modelObject;
  String? title;
  Brand? brand;
  BrandModel? brandModel;
  BrandModelExtension? brandModelExtension;
  Branch? branch;
  String? year;
  ColorCar? color;
  DriveType? driveType;
  BodyType? bodyType;
  FuelType? fuelType;
  Status? status;
  String? price;
  String? doors;
  String? engine;
  String? cylinders;
  String? mileage;
  String? description;
  String? mainImage;
  bool? isBayed;
  List<Images>? images;
  List<Features>? features;

  CarModel(
      {this.id,
        this.modelRole,
        this.modelObject,
        this.title,
        this.brand,
        this.brandModel,
        this.brandModelExtension,
        this.branch,
        this.year,
        this.color,
        this.driveType,
        this.bodyType,
        this.fuelType,
        this.status,
        this.price,
        this.doors,
        this.engine,
        this.cylinders,
        this.mileage,
        this.description,
        this.mainImage,
        this.isBayed  ,
        this.images,
        this.features});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelRole = json['model_role'];
    modelObject = json['model_object'] != null
        ? ModelObject.fromJson(json['model_object'])
        : null;
    title = json['title'];
    isBayed = json['is_buyed'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    brandModel = json['brandModel'] != null
        ? BrandModel.fromJson(json['brandModel'])
        : null;
    brandModelExtension = json['brandModelExtension'] != null
        ? BrandModelExtension.fromJson(json['brandModelExtension'])
        : null;
    branch =
    json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    year = json['year'];
    // color = json['color'];
    color = json['color'] != null
        ? ColorCar.fromJson(json['color'])
        : null;
    driveType = json['drive_Type'] != null
        ? DriveType.fromJson(json['drive_Type'])
        : null;
    bodyType = json['body_Type'] != null
        ? BodyType.fromJson(json['body_Type'])
        : null;
    fuelType = json['fuel_Type'] != null
        ? FuelType.fromJson(json['fuel_Type'])
        : null;
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
    price = double.parse(json['price'].toString().replaceAll(',', '')).toStringAsFixed(0);
    doors = json['doors'];
    engine = json['engine'];
    cylinders = json['cylinders'];
    mileage = json['mileage'];
    description = json['description'];
    mainImage = json['main_image'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_buyed'] = isBayed;
    data['model_role'] = modelRole;
    if (modelObject != null) {
      data['model_object'] = modelObject!.toJson();
    }
    data['title'] = title;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (brandModel != null) {
      data['brandModel'] = brandModel!.toJson();
    }

    if (color != null) {
      data['brandModel'] = color!.toJson();
    }
    if (brandModelExtension != null) {
      data['brandModelExtension'] = brandModelExtension!.toJson();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    data['year'] = year;
    // data['color'] = color;
    if (driveType != null) {
      data['drive_Type'] = driveType!.toJson();
    }
    if (bodyType != null) {
      data['body_Type'] = bodyType!.toJson();
    }
    if (fuelType != null) {
      data['fuel_Type'] = fuelType!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    data['price'] = price;
    data['doors'] = doors;
    data['engine'] = engine;
    data['cylinders'] = cylinders;
    data['mileage'] = mileage;
    data['description'] = description;
    data['main_image'] = mainImage;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BodyType {
  int? id;
  String? name;
  String? icon;

  BodyType({this.id, this.name  , this.icon});

  BodyType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}

class ModelObject {
  int? id;
  String? name;
  String? phone;
  String? whatsApp;
  String? description;
  String? image;
  String? countCars;
  String? coverImage ;

  ModelObject({this.id, this.description, this.name ,  this.phone , this.whatsApp , this.countCars , this.image , this.coverImage});

  ModelObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'] ;
    whatsApp = json['whatsapp'] ;
    countCars = json['count_cars'].toString() ;
    image = json['image'] ;
    description = json['description'] ;
    coverImage = json['cover_image'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['description'] = description;
    data['whatsapp'] = whatsApp;
    data['count_cars'] = countCars;
    data['image'] = image;
    data['cover_image']  = coverImage ; 
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  String? image;

  Brand({this.id, this.name, this.image});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class BrandModel {
  int? id;
  String? brand;
  String? name;

  BrandModel({this.id, this.brand, this.name});

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand'] = brand;
    data['name'] = name;
    return data;
  }
}

class BrandModelExtension {
  int? id;
  String? model;
  String? name;

  BrandModelExtension({this.id, this.model, this.name});

  BrandModelExtension.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model'] = model;
    data['name'] = name;
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  String? city;
  String? district;
  String? address;

  Branch({this.id, this.name, this.city, this.district, this.address});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    district = json['district'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['district'] = district;
    data['address'] = address;
    return data;
  }
}

class DriveType {
  String? key;
  String? name;

  DriveType({this.key, this.name});

  DriveType.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    return data;
  }
}

class Images {
  int? id;
  String? image;

  Images({this.id, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}

class Features {
  int? id;
  String? name;
  List<Options>? options;

  Features({this.id, this.name, this.options});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Options {
  int? id;
  String? name;
  String? icon ;
  Options({this.id, this.name , this.icon});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}
class Status {
  String? key;
  String? name;

  Status({this.key, this.name});

  Status.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}


class FuelType {
  String? key;
  String? name;

  FuelType({this.key, this.name});

  FuelType.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }



}


class ColorCar {
  int? id;
  String? name;
  String? value;

  ColorCar({this.id, this.name, this.value});

  ColorCar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

