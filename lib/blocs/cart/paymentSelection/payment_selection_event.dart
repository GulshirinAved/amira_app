// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_selection_bloc.dart';

class PaymentSelectionEvent extends Equatable {
  final String pressedTitle;
  final String pressedId;

  const PaymentSelectionEvent(
    this.pressedTitle,
    this.pressedId,
  );

  @override
  List<Object> get props => [pressedTitle, pressedId];
}
