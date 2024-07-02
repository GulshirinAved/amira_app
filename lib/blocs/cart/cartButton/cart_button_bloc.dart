import 'package:amira_app/data/models/cart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_button_event.dart';
part 'cart_button_state.dart';

class CartButtonBloc extends Bloc<CartButtonEvent, CartButtonState> {
  CartButtonBloc() : super(CartButtonInitial(cartList: [])) {
    List<CartItem> updatedList = [];

    on<AddCartEvent>((event, emit) {
      updatedList = List<CartItem>.from(state.cartList)..add(event.cartItem!);
      emit(CartButtonSuccess(cartList: updatedList));
    });

    on<PlusButtonEvent>((event, emit) {
      updatedList = List<CartItem>.from(state.cartList);
      final index =
          updatedList.indexWhere((item) => item.id == event.cartItem!.id);
      if (index != -1) {
        updatedList[index] = updatedList[index].copyWith(
          quantity: updatedList[index].quantity + 1,
        );
        emit(CartButtonSuccess(cartList: updatedList));
      }
    });

    on<MinusButtonEvent>((event, emit) {
      updatedList = List<CartItem>.from(state.cartList);
      final index =
          updatedList.indexWhere((item) => item.id == event.cartItem!.id);
      if (index != -1) {
        if (updatedList[index].quantity > 1) {
          updatedList[index] = updatedList[index].copyWith(
            quantity: updatedList[index].quantity - 1,
          );
        } else {
          updatedList.removeAt(index);
        }
        emit(CartButtonSuccess(cartList: updatedList));
      }
    });
    on<RemoveCartEvent>((event, emit) {
      final updatedList = List<CartItem>.from(state.cartList);
      final index =
          updatedList.indexWhere((item) => item.id == event.cartItem!.id);
      updatedList.removeAt(index);
      emit(CartButtonSuccess(cartList: updatedList));
    });
    on<SumProductEvent>((event, emit) {
      final updatedList = List<CartItem>.from(state.cartList);
      double priceOfProducts = 0;

      for (int i = 0; i < updatedList.length; i++) {
        final double price = double.parse(updatedList[i].price!);
        priceOfProducts += price * updatedList[i].quantity;
      }
      print(priceOfProducts);
      emit(
        SumProductState(
          cartList: state.cartList,
          sum: state.sum ?? 0 + priceOfProducts,
        ),
      );
    });
  }
}
