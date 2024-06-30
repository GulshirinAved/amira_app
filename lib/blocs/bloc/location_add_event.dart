part of 'location_add_bloc.dart';

sealed class LocationAddEvent extends Equatable {
  final String? locationName;

  const LocationAddEvent(
    this.locationName,
  );

  @override
  List<Object> get props => [locationName ?? ''];
}

final class SaveAddressEvent extends LocationAddEvent {
  const SaveAddressEvent(
    super.locationName,
  );
}

final class ShowSavedAddressEvent extends LocationAddEvent {
  const ShowSavedAddressEvent(
    super.locationName,
  );
}

final class LoadAddressEvent extends LocationAddEvent {
  const LoadAddressEvent(
    super.locationName,
  );
}

final class SelectAddressEvent extends LocationAddEvent {
  final int index;
  final List<dynamic> addressList;
  SelectAddressEvent(super.locationName, this.index, this.addressList);
  @override
  List<Object> get props => [index, addressList];
}

final class OnButtonPressedAddressEvent extends LocationAddEvent {
  final List<dynamic> addressList;

  const OnButtonPressedAddressEvent(
    super.locationName,
    this.addressList,
  );
}
