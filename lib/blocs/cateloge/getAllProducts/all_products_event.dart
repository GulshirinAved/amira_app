// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_products_bloc.dart';

sealed class AllProductsEvent extends Equatable {
  const AllProductsEvent();

  @override
  List<Object> get props => [];
}

class GetAllProductsList extends AllProductsEvent {
  final Map<String, dynamic> postData;
  const GetAllProductsList({required this.postData});
  @override
  List<Object> get props => [
        postData,
      ];
}

class AllProductsLoadMoreEvent extends AllProductsEvent {
  const AllProductsLoadMoreEvent();
  @override
  List<Object> get props => [];
}
