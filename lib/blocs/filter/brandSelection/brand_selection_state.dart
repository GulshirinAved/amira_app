// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'brand_selection_bloc.dart';

class BrandSelectionState extends Equatable {
  final int selectedIndex;
  const BrandSelectionState(
    this.selectedIndex,
  );

  @override
  List<Object> get props => [selectedIndex];

  BrandSelectionState copyWith({
    int? selectedIndex,
  }) {
    return BrandSelectionState(
      selectedIndex ?? this.selectedIndex,
    );
  }
}
