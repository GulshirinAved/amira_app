import 'dart:convert';

import 'package:amira_app/data/models/home_model.dart';

class GetOneProduct {
  int? statusCode;
  bool? success;
  Data? data;

  GetOneProduct({
    this.statusCode,
    this.success,
    this.data,
  });

  factory GetOneProduct.fromRawJson(String str) =>
      GetOneProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOneProduct.fromJson(Map<String, dynamic> json) => GetOneProduct(
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
  Product? product;
  List<Product>? similaryProducts;

  Data({
    this.product,
    this.similaryProducts,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        product:
            json['product'] == null ? null : Product.fromJson(json['product']),
        similaryProducts: json['similaryProducts'] == null
            ? []
            : List<Product>.from(
                json['similaryProducts']!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'product': product?.toJson(),
        'similaryProducts': similaryProducts == null
            ? []
            : List<dynamic>.from(similaryProducts!.map((x) => x.toJson())),
      };
}

class Product {
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
  Brand? shop;
  List<Category>? categories;
  String? name;
  String? description;
  bool? isLiked;
  final SimpleDiscount? discount;

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
    this.brand,
    this.shop,
    this.categories,
    this.name,
    this.description,
    this.discount,
    this.isLiked,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        price: json['price'],
        usd: json['usd'],
        coin: json['coin'],
        images: json['images'] == null
            ? []
            : List<Image>.from(json['images']!.map((x) => Image.fromJson(x))),
        brandId: json['brandId'],
        shopId: json['shopId'],
        quantity: json['quantity'],
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt']),
        visibility: json['visibility'],
        brand: json['brand'] == null ? null : Brand.fromJson(json['brand']),
        shop: json['shop'] == null ? null : Brand.fromJson(json['shop']),
        categories: json['categories'] == null
            ? []
            : List<Category>.from(
                json['categories']!.map((x) => Category.fromJson(x))),
        name: json['name'],
        description: json['description'],
        discount: json['discount'] == null
            ? null
            : SimpleDiscount.fromJson(json['discount']),
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
        'shop': shop?.toJson(),
        'categories': categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        'name': name,
        'description': description,
        'discount': discount?.toJson(),
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

class Category {
  String? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
