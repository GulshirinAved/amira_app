// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_radio_button_selection_bloc.dart';

class CategoryRadioButtonSelectionState {
  final String? selectedTitle;
  final String? tempSelectedTitle;
  final String? selectedId;

  CategoryRadioButtonSelectionState(
      {this.selectedTitle, this.tempSelectedTitle, this.selectedId});

  CategoryRadioButtonSelectionState copyWith(
      {String? selectedTitle, String? tempSelectedTitle, String? selectedId}) {
    return CategoryRadioButtonSelectionState(
      selectedTitle: selectedTitle ?? this.selectedTitle,
      tempSelectedTitle: tempSelectedTitle ?? this.tempSelectedTitle,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
