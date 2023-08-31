class AdminCars {
  int? id;
  String? title;
  Brand? brand;
  BrandModel? brandModel;
  BrandModelExtension? brandModelExtension;
  String? branch;
  String? year;
  ColorCar? color;
  DriveType? driveType;
  DriveType? bodyType;
  DriveType? fuelType;
  DriveType? status;
  int? price;
  int? doors;
  bool? isBayed;
  String? engine;
  String? cylinders;
  String? mileage;
  String? description;
  String? mainImage;
  ModelObjectr? modelObject;
  List<CarImages>? images;
  String? door1Img;
  String? door2Img;
  String? door3Img;
  String? door4Img;
  List<Features>? features;
  List<Reports>? reports;

  AdminCars(
      {this.id,
        this.title,
        this.brand,
        this.isBayed ,
        this.brandModel,
        this.brandModelExtension,
        this.branch,
        this.modelObject,

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
        this.images,
        this.door1Img,
        this.door2Img,
        this.door3Img,
        this.door4Img,
        this.features,
        this.reports});

  AdminCars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isBayed = json['is_buyed'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    modelObject = json['model_object'] != null
        ? ModelObjectr.fromJson(json['model_object'])
        : null;
    brandModel = json['brandModel'] != null
        ? BrandModel.fromJson(json['brandModel'])
        : null;
    brandModelExtension = json['brandModelExtension'] != null
        ? BrandModelExtension.fromJson(json['brandModelExtension'])
        : null;
    branch = json['branch'];
    year = json['year'];
    color = json['color'] != null
        ? ColorCar.fromJson(json['color'])
        : null;
    driveType = json['drive_Type'] != null
        ? DriveType.fromJson(json['drive_Type'])
        : null;
    bodyType = json['body_Type'] != null
        ? DriveType.fromJson(json['body_Type'])
        : null;
    fuelType = json['fuel_Type'] != null
        ? DriveType.fromJson(json['fuel_Type'])
        : null;
    status =
    json['status'] != null ? DriveType.fromJson(json['status']) : null;
    price = json['price'];
    doors = json['doors'];
    engine = json['engine'];
    cylinders = json['cylinders'];
    mileage = json['mileage'];
    description = json['description'];
    mainImage = json['main_image'];
    if (json['images'] != null) {
      images = <CarImages>[];
      json['images'].forEach((v) {
        images!.add(CarImages.fromJson(v));
      });
    }
    door1Img = json['door1_img'];
    door2Img = json['door2_img'];
    door3Img = json['door3_img'];
    door4Img = json['door4_img'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    if (json['reports'] != null) {
      reports = <Reports>[];
      json['reports'].forEach((v) {
        reports!.add(Reports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (modelObject != null) {
      data['model_object'] = modelObject!.toJson();
    }
    if (brandModel != null) {
      data['brandModel'] = brandModel!.toJson();
    }
    if (brandModelExtension != null) {
      data['brandModelExtension'] = brandModelExtension!.toJson();
    }
    data['branch'] = branch;
    data['year'] = year;

    if (driveType != null) {
      data['drive_Type'] = driveType!.toJson();
    }


    if (color != null) {
      data['color'] = color!.toJson();
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
    data['is_buyed'] = isBayed;
    data['doors'] = doors;
    data['engine'] = engine;
    data['cylinders'] = cylinders;
    data['mileage'] = mileage;
    data['description'] = description;
    data['main_image'] = mainImage;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['door1_img'] = door1Img;
    data['door2_img'] = door2Img;
    data['door3_img'] = door3Img;
    data['door4_img'] = door4Img;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    if (reports != null) {
      data['reports'] = reports!.map((v) => v.toJson()).toList();
    }
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

class Features {
  int? id;
  String? name;
  List<Optionsr>? options;

  Features({this.id, this.name, this.options});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['options'] != null) {
      options = <Optionsr>[];
      json['options'].forEach((v) {
        options!.add(Optionsr.fromJson(v));
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

class Optionsr {
  int? id;
  String? name;
  String? icon;

  Optionsr({this.id, this.name , this.icon});

  Optionsr.fromJson(Map<String, dynamic> json) {
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

class CarImages {
  int? id;
  String? image;

  CarImages({this.id, this.image});

  CarImages.fromJson(Map<String, dynamic> json) {
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


class Reports {
  int? id;
  String? name;
  List<ROptions>? options;

  Reports({this.id, this.name, this.options});

  Reports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['options'] != null) {
      options = <ROptions>[];
      json['options'].forEach((v) {
        options!.add(ROptions.fromJson(v));
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

class ROptions {
  int? id;
  String? name;
  String? image;
  String? icon;

  ROptions({this.id, this.name, this.image , this.icon});

  ROptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['icon'] = icon;
    return data;
  }
}
class ModelObjectr {
  int? id;
  String? name;
  String? phone;
  String? whatsApp;
  String? image;
  String? countCars;

  ModelObjectr({this.id, this.name ,  this.phone , this.whatsApp , this.countCars , this.image});

  ModelObjectr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'] ;
    whatsApp = json['whatsapp'] ;
    countCars = json['count_cars'] ;
    image = json['image'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['whatsapp'] = whatsApp;
    data['count_cars'] = countCars;
    data['image'] = image;
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