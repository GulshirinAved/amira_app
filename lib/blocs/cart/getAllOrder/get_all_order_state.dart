part of 'get_all_order_bloc.dart';

sealed class GetAllOrderState extends Equatable {
  const GetAllOrderState();

  @override
  List<Object> get props => [];
}

final class GetAllOrderInitial extends GetAllOrderState {}

final class GetAllOrderLoading extends GetAllOrderState {}

final class GetAllOrderLoaded extends GetAllOrderState {
  final List<dynamic> allOrdersList;

  const GetAllOrderLoaded({required this.allOrdersList});

  @override
  List<Object> get props => [allOrdersList];
}

final class GetAllOrderError extends GetAllOrderState {
  final String? error;

  const GetAllOrderError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
