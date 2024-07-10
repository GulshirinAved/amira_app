part of 'favbutton_bloc.dart';

// ignore: must_be_immutable
sealed class FavButtonEvent {}

// ignore: must_be_immutable
class ToggleFavEvent extends FavButtonEvent {
  FavItem item;

  ToggleFavEvent({required this.item});
}

// ignore: must_be_immutable
class LoadFavEvent extends FavButtonEvent {
  LoadFavEvent();
}
