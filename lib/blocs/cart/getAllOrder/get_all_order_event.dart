part of 'get_all_order_bloc.dart';

sealed class GetAllOrderEvent extends Equatable {
  const GetAllOrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrdersList extends GetAllOrderEvent {}

class GetMoreOrderList extends GetAllOrderEvent {}
