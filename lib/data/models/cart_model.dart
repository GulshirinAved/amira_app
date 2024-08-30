// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:amira_app/data/models/home_model.dart';

class CartItem {
  final String id;
  final String? name;
  final List<dynamic>? image;
  final int? price;
  final int? coin;
  final SimpleDiscount? discount;
  final String? desc;
  final String? shopid;
  final Brand? brand;

  int quantity;

  CartItem({
    required this.id,
    this.name,
    this.image,
    this.price,
    this.coin,
    required this.discount,
    this.desc,
    this.shopid,
    this.brand,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'coin': coin,
      'discount': discount?.toJson(),
      'desc': desc,
      'shopid': shopid,
      'brand': brand?.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null
          ? List<dynamic>.from((map['image'] as List<dynamic>))
          : null,
      price: map['price'] != null ? map['price'] as int : null,
      coin: map['coin'] != null ? map['coin'] as int : null,
      discount: map['discount'] != null
          ? SimpleDiscount.fromJson(map['discount'] as Map<String, dynamic>)
          : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      shopid: map['shopid'] != null ? map['shopid'] as String : null,
      brand: map['brand'] != null
          ? Brand.fromJson(map['brand'] as Map<String, dynamic>)
          : null,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem copyWith({
    String? id,
    String? name,
    List<dynamic>? image,
    int? price,
    int? coin,
    SimpleDiscount? discount,
    String? desc,
    String? shopid,
    Brand? brand,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      coin: coin ?? this.coin,
      discount: discount ?? this.discount,
      desc: desc ?? this.desc,
      shopid: shopid ?? this.shopid,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.image, image) &&
        other.price == price &&
        other.coin == coin &&
        other.discount == discount &&
        other.desc == desc &&
        other.shopid == shopid &&
        other.brand == brand &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        coin.hashCode ^
        discount.hashCode ^
        desc.hashCode ^
        shopid.hashCode ^
        brand.hashCode ^
        quantity.hashCode;
  }
}
