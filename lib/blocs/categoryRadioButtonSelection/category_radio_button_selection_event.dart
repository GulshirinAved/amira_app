part of 'category_radio_button_selection_bloc.dart';

class CategoryRadioButtonSelectionEvent extends Equatable {
  final String pressedTitle;
  const CategoryRadioButtonSelectionEvent(this.pressedTitle);

  @override
  List<Object> get props => [pressedTitle];
}
