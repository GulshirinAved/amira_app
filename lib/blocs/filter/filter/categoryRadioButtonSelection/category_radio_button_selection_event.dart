part of 'category_radio_button_selection_bloc.dart';

class CategoryRadioButtonSelectionEvent {}

class SelectRadioButtonEvent extends CategoryRadioButtonSelectionEvent {
  final String pressedTitle;
  final String pressedId;

  SelectRadioButtonEvent(
    this.pressedTitle,
    this.pressedId,
  );
}

class ApplyRadioButtonEvent extends CategoryRadioButtonSelectionEvent {}
