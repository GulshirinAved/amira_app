part of 'location_add_bloc.dart';

sealed class LocationAddState extends Equatable {
  final List locationList;
  final int? selectedIndex;
  final String savedLocation;
  const LocationAddState(this.selectedIndex,
      {required this.locationList, required this.savedLocation});

  @override
  List<Object> get props => [locationList, selectedIndex!, savedLocation];
}

final class LocationAddInitial extends LocationAddState {
  LocationAddInitial(super.selectedIndex,
      {required super.locationList, required super.savedLocation});
}

final class SaveAddressState extends LocationAddState {
  SaveAddressState(super.selectedIndex,
      {required super.locationList, required super.savedLocation});
}

final class SelectAddressState extends LocationAddState {
  SelectAddressState(
    super.selectedIndex, {
    required super.locationList,
    required super.savedLocation,
  });
}

final class OnButtonPressedState extends LocationAddState {
  OnButtonPressedState(super.selectedIndex,
      {required super.locationList, required super.savedLocation});
}
