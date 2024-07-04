part of 'category_radio_button_selection_bloc.dart';

class CategoryRadioButtonSelectionEvent {}

class SelectRadioButtonEvent extends CategoryRadioButtonSelectionEvent {
  final String pressedTitle;

  SelectRadioButtonEvent(this.pressedTitle);
}

class ApplyRadioButtonEvent extends CategoryRadioButtonSelectionEvent {}
