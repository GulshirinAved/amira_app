// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'price_range_selection_bloc.dart';

class PriceRangeSelectionEvent extends Equatable {
  final int pressedIndex;
  const PriceRangeSelectionEvent(
    this.pressedIndex,
  );

  @override
  List<Object> get props => [pressedIndex];
}
