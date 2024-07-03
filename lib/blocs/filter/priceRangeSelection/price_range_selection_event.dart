// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'price_range_selection_bloc.dart';

sealed class PriceRangeSelectionEvent extends Equatable {
  const PriceRangeSelectionEvent();
}

class SelectPrice extends PriceRangeSelectionEvent {
  final int bottomSheet;
  final int pressedPriceIndex;
  const SelectPrice({
    required this.bottomSheet,
    required this.pressedPriceIndex,
  });

  @override
  List<Object?> get props => [bottomSheet, pressedPriceIndex];
}

class ApplyPriceEvent extends PriceRangeSelectionEvent {
  final int bottomSheet;

  const ApplyPriceEvent({required this.bottomSheet});
  @override
  List<Object> get props => [bottomSheet];
}
