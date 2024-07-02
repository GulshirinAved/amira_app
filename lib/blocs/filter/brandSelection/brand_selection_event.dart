part of 'brand_selection_bloc.dart';

class BrandSelectionEvent extends Equatable {
  final int pressedIndex;
  const BrandSelectionEvent(this.pressedIndex);

  @override
  List<Object> get props => [pressedIndex];
}
