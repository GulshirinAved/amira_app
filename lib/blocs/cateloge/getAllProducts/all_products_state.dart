part of 'all_products_bloc.dart';

sealed class AllProductsState extends Equatable {
  const AllProductsState();

  @override
  List<Object> get props => [];
}

final class AllProductsInitial extends AllProductsState {}

final class AllProductsLoading extends AllProductsState {}

final class AllProductsLoaded extends AllProductsState {
  final List<dynamic> allProductsList;

  const AllProductsLoaded({required this.allProductsList});

  @override
  List<Object> get props => [allProductsList];
}

final class AllProductsError extends AllProductsState {
  final String? error;

  const AllProductsError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
