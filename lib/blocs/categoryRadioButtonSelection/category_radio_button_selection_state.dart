// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_radio_button_selection_bloc.dart';

class CategoryRadioButtonSelectionState {
  final String? selectedTitle;
  final String? tempSelectedTitle;

  CategoryRadioButtonSelectionState({
    this.selectedTitle,
    this.tempSelectedTitle,
  });

  CategoryRadioButtonSelectionState copyWith({
    String? selectedTitle,
    String? tempSelectedTitle,
  }) {
    return CategoryRadioButtonSelectionState(
      selectedTitle: selectedTitle ?? this.selectedTitle,
      tempSelectedTitle: tempSelectedTitle ?? this.tempSelectedTitle,
    );
  }
}
