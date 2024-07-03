// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'brand_selection_bloc.dart';

class BrandSelectionState extends Equatable {
  final int selectedBrandBottomSheet1;
  final int selectedBrandBottomSheet2;

  const BrandSelectionState(
    this.selectedBrandBottomSheet1,
    this.selectedBrandBottomSheet2,
  );
  @override
  List<Object?> get props =>
      [selectedBrandBottomSheet1, selectedBrandBottomSheet2];
}

class BrandSelectionInitial extends BrandSelectionState {
  const BrandSelectionInitial(
      super.selectedBrandBottomSheet1, super.selectedBrandBottomSheet2);
}

class BrandSelectionUpdated extends BrandSelectionState {
  const BrandSelectionUpdated(
      super.selectedBrandBottomSheet1, super.selectedBrandBottomSheet2);
  @override
  List<Object?> get props =>
      [selectedBrandBottomSheet1, selectedBrandBottomSheet2];
}
