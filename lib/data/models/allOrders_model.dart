import 'dart:convert';

class AllOrdersModel {
  final int? statusCode;
  final bool? success;
  final Data? data;

  AllOrdersModel({
    this.statusCode,
    this.success,
    this.data,
  });

  factory AllOrdersModel.fromRawJson(String str) =>
      AllOrdersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) => AllOrdersModel(
        statusCode: json["statusCode"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  final int? count;
  final int? pageCount;
  final List<Row>? rows;

  Data({
    this.count,
    this.pageCount,
    this.rows,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        pageCount: json["pageCount"],
        rows: json["rows"] == null
            ? []
            : List<Row>.from(json["rows"]!.map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pageCount": pageCount,
        "rows": rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class Row {
  final String? id;
  final String? address;
  final DateTime? until;
  final double? price;
  final dynamic userId;
  final String? status;
  final DateTime? createdAt;
  final List<OrderProduct>? orderProducts;

  Row({
    this.id,
    this.address,
    this.until,
    this.price,
    this.userId,
    this.status,
    this.createdAt,
    this.orderProducts,
  });

  factory Row.fromRawJson(String str) => Row.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json["id"],
        address: json["address"],
        until: json["until"] == null ? null : DateTime.parse(json["until"]),
        price: json["price"]?.toDouble(),
        userId: json["userId"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        orderProducts: json["orderProducts"] == null
            ? []
            : List<OrderProduct>.from(
                json["orderProducts"]!.map((x) => OrderProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "until": until?.toIso8601String(),
        "price": price,
        "userId": userId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "orderProducts": orderProducts == null
            ? []
            : List<dynamic>.from(orderProducts!.map((x) => x.toJson())),
      };
}

class OrderProduct {
  final String? id;
  final String? orderId;
  final String? productId;
  final int? quantity;
  final String? shopId;
  final Product? product;

  OrderProduct({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.shopId,
    this.product,
  });

  factory OrderProduct.fromRawJson(String str) =>
      OrderProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"],
        orderId: json["orderId"],
        productId: json["productId"],
        quantity: json["quantity"],
        shopId: json["shopId"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "productId": productId,
        "quantity": quantity,
        "shopId": shopId,
        "product": product?.toJson(),
      };
}

class Product {
  final String? id;
  final int? price;
  final int? usd;
  final int? coin;
  final List<Image>? images;
  final String? brandId;
  final String? shopId;
  final int? quantity;
  final DateTime? createdAt;
  final String? visibility;
  final int? amount;
  final String? unitId;
  final List<Translation>? translations;
  final Shop? shop;
  final String? name;
  final String? description;
  final bool? isLiked;

  Product({
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
    this.amount,
    this.unitId,
    this.translations,
    this.shop,
    this.name,
    this.description,
    this.isLiked,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        usd: json["usd"],
        coin: json["coin"],
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        brandId: json["brandId"],
        shopId: json["shopId"],
        quantity: json["quantity"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        visibility: json["visibility"],
        amount: json["amount"],
        unitId: json["unitId"],
        translations: json["translations"] == null
            ? []
            : List<Translation>.from(
                json["translations"]!.map((x) => Translation.fromJson(x))),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        name: json["name"],
        description: json["description"],
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "usd": usd,
        "coin": coin,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "brandId": brandId,
        "shopId": shopId,
        "quantity": quantity,
        "createdAt": createdAt?.toIso8601String(),
        "visibility": visibility,
        "amount": amount,
        "unitId": unitId,
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x.toJson())),
        "shop": shop?.toJson(),
        "name": name,
        "description": description,
        "isLiked": isLiked,
      };
}

class Image {
  final String? url;
  final String? hashblur;

  Image({
    this.url,
    this.hashblur,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        hashblur: json["hashblur"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "hashblur": hashblur,
      };
}

class Shop {
  final String? id;
  final String? name;
  final String? description;
  final dynamic email;
  final String? phone;
  final Image? logo;
  final DateTime? createdAt;
  final dynamic deletedAt;
  final dynamic applicationId;
  final String? ownerId;

  Shop({
    this.id,
    this.name,
    this.description,
    this.email,
    this.phone,
    this.logo,
    this.createdAt,
    this.deletedAt,
    this.applicationId,
    this.ownerId,
  });

  factory Shop.fromRawJson(String str) => Shop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        email: json["email"],
        phone: json["phone"],
        logo: json["logo"] == null ? null : Image.fromJson(json["logo"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
        applicationId: json["applicationId"],
        ownerId: json["ownerId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "email": email,
        "phone": phone,
        "logo": logo?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "applicationId": applicationId,
        "ownerId": ownerId,
      };
}

class Translation {
  final String? lang;
  final String? name;
  final String? description;
  final String? productId;
  final DateTime? createdAt;
  final dynamic deletedAt;

  Translation({
    this.lang,
    this.name,
    this.description,
    this.productId,
    this.createdAt,
    this.deletedAt,
  });

  factory Translation.fromRawJson(String str) =>
      Translation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        lang: json["lang"],
        name: json["name"],
        description: json["description"],
        productId: json["productId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "lang": lang,
        "name": name,
        "description": description,
        "productId": productId,
        "createdAt": createdAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}
