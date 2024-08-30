import 'package:amira_app/data/models/cart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_button_event.dart';
part 'cart_button_state.dart';

class CartButtonBloc extends Bloc<CartButtonEvent, CartButtonState> {
  final Box box = Hive.box('cartBox');

  CartButtonBloc() : super(const CartButtonInitial(cartList: [])) {
    List<CartItem> updatedList = [];

    on<AddCartEvent>((event, emit) {
      updatedList = List<CartItem>.from(state.cartList)..add(event.cartItem);
      box.put('cartList', updatedList.map((item) => item.toJson()).toList());

      emit(CartButtonSuccess(cartList: updatedList));
    });

    on<PlusButtonEvent>((event, emit) {
      updatedList = List<CartItem>.from(state.cartList);
      final index =
          updatedList.indexWhere((item) => item.id == event.cartItem.id);
      if (index != -1) {
        updatedList[index] = updatedList[index].copyWith(
          quantity: updatedList[index].quantity + 1,
        );
        box.put('cartList', updatedList.map((item) => item.toJson()).toList());
        emit(CartButtonSuccess(cartList: updatedList));
      }
    });

    on<MinusButtonEvent>((event, emit) {
      updatedList = List<CartItem>.from(state.cartList);
      final index =
          updatedList.indexWhere((item) => item.id == event.cartItem.id);
      if (index != -1) {
        if (updatedList[index].quantity > 1) {
          updatedList[index] = updatedList[index].copyWith(
            quantity: updatedList[index].quantity - 1,
          );
        } else {
          updatedList.removeAt(index);
        }
        box.put('cartList', updatedList.map((item) => item.toJson()).toList());

        emit(CartButtonSuccess(cartList: updatedList));
      }
    });

    on<RemoveCartEvent>((event, emit) {
      final updatedList = List<CartItem>.from(state.cartList);
      final index =
          updatedList.indexWhere((item) => item.id == event.cartItem.id);
      if (index != -1) {
        updatedList.removeAt(index);
        box.put('cartList', updatedList.map((item) => item.toJson()).toList());
        emit(CartButtonSuccess(cartList: updatedList));
      }
    });

    on<SumProductEvent>((event, emit) {
      final updatedList = List<CartItem>.from(state.cartList);
      double priceOfProducts = 0;
      double salePrices = 0;

      for (int i = 0; i < updatedList.length; i++) {
        final double price = _parseDouble(updatedList[i].price);
        final double discountPrice =
            _parseDouble(updatedList[i].discount?.price);

        priceOfProducts += price * updatedList[i].quantity;
        salePrices += discountPrice * updatedList[i].quantity;
      }

      box.put('cartList', updatedList.map((item) => item.toJson()).toList());

      emit(
        SumProductState(
          cartList: state.cartList,
          sum: (state.sum ?? 0) + priceOfProducts,
          salePrice: (state.salePrice ?? 0) + salePrices,
        ),
      );
    });

    on<LoadCartEvent>((event, emit) {
      final loadedList = (box.get('cartList', defaultValue: []) as List)
          .map((item) => CartItem.fromJson(item))
          .toList();

      emit(
        SumProductState(
          cartList: loadedList,
          sum: _calculateSum(loadedList),
          salePrice: _calculateSale(loadedList),
        ),
      );
    });
  }

  double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    try {
      return double.parse(value.toString());
    } catch (e) {
      return 0.0;
    }
  }

  double _calculateSum(List<CartItem> cartList) {
    double sum = 0;
    for (var item in cartList) {
      sum += (item.price ?? 0) * item.quantity;
    }
    return sum;
  }

  double _calculateSale(List<CartItem> cartList) {
    double sum = 0;
    for (var item in cartList) {
      sum += (item.discount?.price ?? 0) * item.quantity;
    }
    return sum;
  }
}
