// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'price_range_selection_bloc.dart';

class PriceRangeSelectionState extends Equatable {
  final int selectedPriceBottomSheet1;
  final int selectedPriceBottomSheet2;
  const PriceRangeSelectionState(
      this.selectedPriceBottomSheet1, this.selectedPriceBottomSheet2);

  @override
  List<Object> get props =>
      [selectedPriceBottomSheet1, selectedPriceBottomSheet2];
}

class FilterInitial extends PriceRangeSelectionState {
  const FilterInitial(
      super.selectedPriceBottomSheet1, super.selectedPriceBottomSheet2);
}

class FilterPriceUpdated extends PriceRangeSelectionState {
  const FilterPriceUpdated(
      super.selectedPriceBottomSheet1, super.selectedPriceBottomSheet2);
  @override
  List<Object> get props =>
      [selectedPriceBottomSheet1, selectedPriceBottomSheet2];
}
