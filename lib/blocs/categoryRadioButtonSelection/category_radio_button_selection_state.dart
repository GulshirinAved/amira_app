// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_radio_button_selection_bloc.dart';

class CategoryRadioButtonSelectionState extends Equatable {
  final String? title;
  const CategoryRadioButtonSelectionState(
    this.title,
  );

  @override
  List<Object> get props => [title ?? ''];

  CategoryRadioButtonSelectionState copyWith({
    String? title,
  }) {
    return CategoryRadioButtonSelectionState(
      title ?? this.title,
    );
  }
}
