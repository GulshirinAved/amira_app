import 'dart:convert';

class ProductModel {
  int? statusCode;
  bool? success;
  Data? data;

  ProductModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        statusCode: json['statusCode'],
        success: json['success'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'data': data?.toJson(),
      };
}

class Data {
  int? count;
  int? pageCount;
  DataCategory? category;
  List<Row>? rows;

  Data({
    this.count,
    this.pageCount,
    this.category,
    this.rows,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json['count'],
        pageCount: json['pageCount'],
        category: json['category'] == null
            ? null
            : DataCategory.fromJson(json['category']),
        rows: json['rows'] == null
            ? []
            : List<Row>.from(json['rows'].map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pageCount': pageCount,
        'category': category?.toJson(),
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class DataCategory {
  Id? id;
  Image? image;
  dynamic parentId;
  DateTime? createdAt;
  Name? name;

  DataCategory({
    this.id,
    this.image,
    this.parentId,
    this.createdAt,
    this.name,
  });

  factory DataCategory.fromRawJson(String str) =>
      DataCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
        id: json['id'] == null ? null : idValues.map[json['id']],
        image: json['image'] == null ? null : Image.fromJson(json['image']),
        parentId: json['parentId'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        name: json['name'] == null ? null : nameValues.map[json['name']],
      );

  Map<String, dynamic> toJson() => {
        'id': id == null ? null : idValues.reverse[id],
        'image': image?.toJson(),
        'parentId': parentId,
        'createdAt': createdAt?.toIso8601String(),
        'name': name == null ? null : nameValues.reverse[name],
      };
}

enum Id { CATEGORY1, CATEGORY1_SUBCATEGORY1, CATEGORY1_SUBCATEGORY2, CATEGORY2 }

final idValues = EnumValues({
  'category1': Id.CATEGORY1,
  'category1-subcategory1': Id.CATEGORY1_SUBCATEGORY1,
  'category1-subcategory2': Id.CATEGORY1_SUBCATEGORY2,
  'category2': Id.CATEGORY2
});

class Image {
  String? url;
  String? hashblur;

  Image({
    this.url,
    this.hashblur,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json['url'],
        hashblur: json['hashblur'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'hashblur': hashblur,
      };
}

enum Name { CATEGORY1_EN, CATEGORY2_EN, SUBCATEGORY1_EN, SUBCATEGORY2_EN }

final nameValues = EnumValues({
  'category1-en': Name.CATEGORY1_EN,
  'category2-en': Name.CATEGORY2_EN,
  'subcategory1-en': Name.SUBCATEGORY1_EN,
  'subcategory2-en': Name.SUBCATEGORY2_EN
});

class Row {
  String? id;
  int? price;
  int? usd;
  int? coin;
  List<Image>? images;
  String? brandId;
  String? shopId;
  int? quantity;
  DateTime? createdAt;
  String? visibility;
  Brand? brand;
  List<CategoryElement>? categories;
  String? name;
  String? description;
  bool? isLiked;

  Row({
    this.id,
    this.price,
    this.usd,
    this.coin,
    this.images,
    this.brandId,
    this.shopId,
    this.quantity,
    this.createdAt,
    this.visibility,
    this.brand,
    this.categories,
    this.name,
    this.description,
    this.isLiked,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        price: json['price'],
        usd: json['usd'],
        coin: json['coin'],
        images: json['images'] == null
            ? []
            : List<Image>.from(json['images'].map((x) => Image.fromJson(x))),
        brandId: json['brandId'],
        shopId: json['shopId'],
        quantity: json['quantity'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        visibility: json['visibility'],
        brand: json['brand'] == null ? null : Brand.fromJson(json['brand']),
        categories: json['categories'] == null
            ? []
            : List<CategoryElement>.from(
                json['categories']!.map((x) => CategoryElement.fromJson(x))),
        name: json['name'],
        description: json['description'],
        isLiked: json['isLiked'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'usd': usd,
        'coin': coin,
        'images': images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        'brandId': brandId,
        'shopId': shopId,
        'quantity': quantity,
        'createdAt': createdAt?.toIso8601String(),
        'visibility': visibility,
        'brand': brand?.toJson(),
        'categories': categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        'name': name,
        'description': description,
        'isLiked': isLiked,
      };
}

class Brand {
  String? id;
  String? name;
  Image? logo;
  DateTime? createdAt;

  Brand({
    this.id,
    this.name,
    this.logo,
    this.createdAt,
  });

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json['id'],
        name: json['name'],
        logo: json['logo'] == null ? null : Image.fromJson(json['logo']),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo?.toJson(),
        'createdAt': createdAt?.toIso8601String(),
      };
}

class CategoryElement {
  Id? id;
  Name? name;

  CategoryElement({
    this.id,
    this.name,
  });

  factory CategoryElement.fromRawJson(String str) =>
      CategoryElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json['id'] == null ? null : idValues.map[json['id']],
        name: json['name'] == null ? null : nameValues.map[json['name']],
      );

  Map<String, dynamic> toJson() => {
        'id': id == null ? null : idValues.reverse[id],
        'name': name == null ? null : nameValues.reverse[name],
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
