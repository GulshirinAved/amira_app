// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sub_category_selection_bloc.dart';

class SubCategorySelectionState extends Equatable {
  final String subcategoryName;
  const SubCategorySelectionState({required this.subcategoryName});

  @override
  List<Object> get props => [subcategoryName];

  SubCategorySelectionState copyWith({
    String? subcategoryName,
  }) {
    return SubCategorySelectionState(
      subcategoryName: subcategoryName ?? this.subcategoryName,
    );
  }
}
