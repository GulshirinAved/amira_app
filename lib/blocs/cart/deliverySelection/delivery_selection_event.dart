// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delivery_selection_bloc.dart';

class DeliverySelectionEvent extends Equatable {
  final String pressedTitle;
  final String pressedId;

  const DeliverySelectionEvent(
    this.pressedTitle,
    this.pressedId,
  );

  @override
  List<Object> get props => [pressedTitle, pressedId];
}
