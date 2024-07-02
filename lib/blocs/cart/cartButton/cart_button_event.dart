part of 'cart_button_bloc.dart';

sealed class CartButtonEvent extends Equatable {
  final CartItem? cartItem;
  const CartButtonEvent(this.cartItem);

  @override
  List<Object> get props => [cartItem!];
}

final class AddCartEvent extends CartButtonEvent {
  const AddCartEvent(
    super.cartItem,
  );
}

final class PlusButtonEvent extends CartButtonEvent {
  const PlusButtonEvent(
    super.cartItem,
  );
}

final class MinusButtonEvent extends CartButtonEvent {
  const MinusButtonEvent(
    super.cartItem,
  );
  @override
  List<Object> get props => [cartItem!];
}

final class RemoveCartEvent extends CartButtonEvent {
  const RemoveCartEvent(
    super.cartItem,
  );
  @override
  List<Object> get props => [cartItem!];
}

final class SumProductEvent extends CartButtonEvent {
  const SumProductEvent(
    super.cartItem,
  );
  @override
  List<Object> get props => [cartItem!];
}
