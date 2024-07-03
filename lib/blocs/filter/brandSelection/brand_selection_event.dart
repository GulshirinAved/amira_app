// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'brand_selection_bloc.dart';

sealed class BrandSelectionEvent extends Equatable {
  const BrandSelectionEvent();

  @override
  List<Object> get props => [];
}

class SelectBrand extends BrandSelectionEvent {
  final int bottomSheet;
  final int pressedBrandIndex;

  const SelectBrand(
    this.bottomSheet,
    this.pressedBrandIndex,
  );

  @override
  List<Object> get props => [bottomSheet, pressedBrandIndex];
}

class ApplyBrandEvent extends BrandSelectionEvent {
  final int bottomSheet;

  const ApplyBrandEvent({required this.bottomSheet});
  @override
  List<Object> get props => [bottomSheet];
}
