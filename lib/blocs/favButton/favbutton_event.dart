part of 'favbutton_bloc.dart';

// ignore: must_be_immutable
sealed class FavButtonEvent extends Equatable {
  FavItem item;

  FavButtonEvent({required this.item});

  @override
  List<Object> get props => [item];
}

class ToggleFavEvent extends FavButtonEvent {
  ToggleFavEvent({required super.item});
}
