import 'dart:convert';

import 'package:flutter/foundation.dart';

class FavItem {
  final String id;
  final String? name;
  final List<dynamic>? image;
  final int? price;
  final String? prevPrice;
  final String? discount;
  final String? desc;
  final String? shopid;
  bool? isfavorite;

  FavItem({
    required this.id,
    this.name,
    this.image,
    this.price,
    this.prevPrice,
    this.discount,
    this.desc,
    this.shopid,
    this.isfavorite = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'prevPrice': prevPrice,
      'discount': discount,
      'desc': desc,
      'shopid': shopid,
      'isfavorite': isfavorite,
    };
  }

  factory FavItem.fromMap(Map<String, dynamic> map) {
    return FavItem(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null
          ? List<dynamic>.from((map['image'] as List<dynamic>))
          : [],
      price: map['price'] != null ? map['price'] as int : null,
      prevPrice: map['prevPrice'] != null ? map['prevPrice'] as String : null,
      discount: map['discount'] != null ? map['discount'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      shopid: map['shopid'] != null ? map['shopid'] as String : null,
      isfavorite: map['isfavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavItem.fromJson(String source) =>
      FavItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant FavItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.image, image) &&
        other.price == price &&
        other.prevPrice == prevPrice &&
        other.discount == discount &&
        other.desc == desc &&
        other.shopid == shopid &&
        other.isfavorite == isfavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        prevPrice.hashCode ^
        discount.hashCode ^
        desc.hashCode ^
        shopid.hashCode ^
        isfavorite.hashCode;
  }

  FavItem copyWith({
    String? id,
    String? name,
    List<dynamic>? image,
    int? price,
    String? prevPrice,
    String? discount,
    String? desc,
    String? shopid,
    bool? isfavorite,
  }) {
    return FavItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      prevPrice: prevPrice ?? this.prevPrice,
      discount: discount ?? this.discount,
      desc: desc ?? this.desc,
      shopid: shopid ?? this.shopid,
      isfavorite: isfavorite ?? this.isfavorite,
    );
  }
}
