part of 'sub_category_selection_bloc.dart';

class SubCategorySelectionEvent extends Equatable {
  final String pressedName;
  const SubCategorySelectionEvent({required this.pressedName});

  @override
  List<Object> get props => [pressedName];
}
