import 'dart:convert';

class HomeModel {
  int? statusCode;
  bool? success;
  List<Datum>? data;

  HomeModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory HomeModel.fromRawJson(String str) =>
      HomeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        statusCode: json['statusCode'],
        success: json['success'],
        data: json['data'] == null
            ? []
            : List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? type;
  int? count;
  String? categoryId;
  Category? category;
  List<Row>? rows;

  Datum({
    this.id,
    this.type,
    this.count,
    this.categoryId,
    this.category,
    this.rows,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'],
        type: json['type'],
        count: json['count'],
        categoryId: json['categoryId'],
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category']),
        rows: json['rows'] == null
            ? []
            : List<Row>.from(json['rows'].map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'count': count,
        'categoryId': categoryId,
        'category': category?.toJson(),
        'rows': rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Category {
  String? id;
  Image? image;
  String? parentId;
  DateTime? createdAt;
  String? name;

  Category({
    this.id,
    this.image,
    this.parentId,
    this.createdAt,
    this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        image: json['image'] == null ? null : Image.fromJson(json['image']),
        parentId: json['parentId'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image?.toJson(),
        'parentId': parentId,
        'createdAt': createdAt?.toIso8601String(),
        'name': name,
      };
}

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

class Row {
  String? id;
  DateTime? createdAt;
  Image? image;
  int? price;
  int? usd;
  int? coin;
  List<Image>? images;
  String? brandId;
  String? shopId;
  int? quantity;
  String? visibility;
  String? name;
  String? description;
  bool? isLiked;
  String? type;
  String? title;
  String? content;
  int? amount;
  String? unitId;
  final Brand? brand;
  final List<CategoryElement>? categories;
  final SimpleDiscount? discount;

  Row({
    this.id,
    this.createdAt,
    this.image,
    this.price,
    this.usd,
    this.coin,
    this.images,
    this.brandId,
    this.shopId,
    this.quantity,
    this.visibility,
    this.name,
    this.description,
    this.isLiked,
    this.type,
    this.title,
    this.content,
    this.amount,
    this.unitId,
    this.brand,
    this.categories,
    this.discount,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        image: json['image'] == null ? null : Image.fromJson(json['image']),
        price: json['price'],
        usd: json['usd'],
        coin: json['coin'],
        images: json['images'] == null
            ? []
            : List<Image>.from(json['images'].map((x) => Image.fromJson(x))),
        brandId: json['brandId'],
        shopId: json['shopId'],
        quantity: json['quantity'],
        visibility: json['visibility'],
        name: json['name'],
        description: json['description'],
        isLiked: json['isLiked'],
        type: json['type'],
        title: json['title'],
        content: json['content'],
        amount: json['amount'],
        unitId: json['unitId'],
        brand: json['brand'] == null ? null : Brand.fromJson(json['brand']),
        categories: json['categories'] == null
            ? []
            : List<CategoryElement>.from(
                json['categories']!.map((x) => CategoryElement.fromJson(x))),
        discount: json['discount'] == null
            ? null
            : SimpleDiscount.fromJson(json['discount']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt?.toIso8601String(),
        'image': image?.toJson(),
        'price': price,
        'usd': usd,
        'coin': coin,
        'images': images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        'brandId': brandId,
        'shopId': shopId,
        'quantity': quantity,
        'visibility': visibility,
        'name': name,
        'description': description,
        'isLiked': isLiked,
        'type': type,
        'title': title,
        'content': content,
        'amount': amount,
        'unitId': unitId,
        'brand': brand?.toJson(),
        'categories': categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        'discount': discount?.toJson(),
      };
}

class Brand {
  final String? id;
  final String? name;
  final Image? logo;
  final DateTime? createdAt;

  Brand({
    this.id,
    this.name,
    this.logo,
    this.createdAt,
  });

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        logo: json["logo"] == null ? null : Image.fromJson(json["logo"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
      };
}

class CategoryElement {
  final String? id;
  final String? name;

  CategoryElement({
    this.id,
    this.name,
  });

  factory CategoryElement.fromRawJson(String str) =>
      CategoryElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class SimpleDiscount {
  final int? price;
  final int? percent;

  SimpleDiscount({
    this.price,
    this.percent,
  });

  factory SimpleDiscount.fromRawJson(String str) =>
      SimpleDiscount.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SimpleDiscount.fromJson(Map<String, dynamic> json) => SimpleDiscount(
        price: json["price"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "percent": percent,
      };
}
