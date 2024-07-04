part of 'all_category_bloc.dart';

sealed class AllCategoryState extends Equatable {
  const AllCategoryState();

  @override
  List<Object> get props => [];
}

final class AllCategoryInitial extends AllCategoryState {}

final class AllCategoryLoading extends AllCategoryState {}

final class AllCategoryLoaded extends AllCategoryState {
  final List<dynamic> allCategoryList;
  final int categoryCount;

  const AllCategoryLoaded(
      {required this.allCategoryList, required this.categoryCount});
  @override
  List<Object> get props => [allCategoryList, categoryCount];
}

final class AllCategoryError extends AllCategoryState {
  final String? error;

  const AllCategoryError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
