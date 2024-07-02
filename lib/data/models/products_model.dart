// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductsModel {
  final int id;
  final String? name;
  final String? image;
  final String? price;
  final String? prevPrice;
  final String? discount;
  final String? desc;
  ProductsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.prevPrice,
    required this.discount,
    required this.desc,
  });

  ProductsModel copyWith({
    int? id,
    String? name,
    String? image,
    String? price,
    String? prevPrice,
    String? discount,
    String? desc,
  }) {
    return ProductsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      prevPrice: prevPrice ?? this.prevPrice,
      discount: discount ?? this.discount,
      desc: desc ?? this.desc,
    );
  }

  @override
  bool operator ==(covariant ProductsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.price == price &&
        other.prevPrice == prevPrice &&
        other.discount == discount &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        prevPrice.hashCode ^
        discount.hashCode ^
        desc.hashCode;
  }
}
