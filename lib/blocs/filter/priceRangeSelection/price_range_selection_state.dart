// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'price_range_selection_bloc.dart';

class PriceRangeSelectionState extends Equatable {
  final int selectedIndex;
  const PriceRangeSelectionState(
    this.selectedIndex,
  );

  @override
  List<Object> get props => [selectedIndex];

  PriceRangeSelectionState copyWith({
    int? selectedIndex,
  }) {
    return PriceRangeSelectionState(
      selectedIndex ?? this.selectedIndex,
    );
  }
}
