part of 'get_all_brands_bloc.dart';

sealed class GetAllBrandsEvent extends Equatable {
  const GetAllBrandsEvent();

  @override
  List<Object> get props => [];
}

class GetAllBrandsList extends GetAllBrandsEvent {
  final String categoryId;

  const GetAllBrandsList({required this.categoryId});
  @override
  List<Object> get props => [categoryId];
}
