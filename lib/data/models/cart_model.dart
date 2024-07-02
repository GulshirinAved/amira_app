// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  final int id;
  final String? name;
  final String? image;
  final String? price;
  final String? prevPrice;
  final String? discount;
  final String? desc;
  int quantity;

  CartItem({
    required this.id,
    this.name,
    this.image,
    this.price,
    this.prevPrice,
    this.discount,
    this.desc,
    this.quantity = 1,
  });

  CartItem copyWith({
    int? id,
    String? name,
    String? image,
    String? price,
    String? prevPrice,
    String? discount,
    String? desc,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      prevPrice: prevPrice ?? this.prevPrice,
      discount: discount ?? this.discount,
      desc: desc ?? this.desc,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.price == price &&
        other.prevPrice == prevPrice &&
        other.discount == discount &&
        other.desc == desc &&
        other.quantity == quantity;
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
        quantity.hashCode;
  }
}
