// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'brand_selection_bloc.dart';

sealed class BrandSelectionEvent extends Equatable {
  const BrandSelectionEvent();

  @override
  List<Object> get props => [];
}

class SelectBrand extends BrandSelectionEvent {
  final int bottomSheet;
  final String pressedBrandName;
  final String brandId;

  const SelectBrand(
    this.bottomSheet,
    this.pressedBrandName,
    this.brandId,
  );

  @override
  List<Object> get props => [bottomSheet, pressedBrandName];
}

class ApplyBrandEvent extends BrandSelectionEvent {
  final int bottomSheet;

  const ApplyBrandEvent({required this.bottomSheet});
  @override
  List<Object> get props => [bottomSheet];
}

class ClearBrandEvent extends BrandSelectionEvent {
  const ClearBrandEvent();
}
