import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'location_add_event.dart';
part 'location_add_state.dart';

class LocationAddBloc extends Bloc<LocationAddEvent, LocationAddState> {
  final Box addressBox = Hive.box('addressBox');

  LocationAddBloc()
      : super(
          const LocationAddInitial(
            -1,
            savedLocation: '',
            locationList: [],
          ),
        ) {
    on<SaveAddressEvent>((event, emit) async {
      final List<String> currentList = List<String>.from(
        addressBox.get('addressList', defaultValue: <String>[]),
      );

// Check if the location already exists in the list
      if (!currentList.contains(event.locationName)) {
        currentList.add(event.locationName!);
        await addressBox.put('addressList', currentList);
      }

      final String savedLocation =
          addressBox.get('savedAddress', defaultValue: '');

      emit(
        SaveAddressState(
          -1,
          savedLocation: savedLocation,
          locationList: currentList,
        ),
      );
    });

    on<ShowSavedAddressEvent>((event, emit) async {
      final List<String> addresses = List<String>.from(
        addressBox.get('addressList', defaultValue: <String>[]),
      );
      final String savedDeliveryLocation =
          addressBox.get('savedAddress', defaultValue: '');
      emit(
        SaveAddressState(
          -1,
          savedLocation: savedDeliveryLocation,
          locationList: addresses,
        ),
      );
    });

    on<SelectAddressEvent>((event, emit) async {
      final String savedDeliveryLocation =
          addressBox.get('savedAddress', defaultValue: '');
      emit(
        SaveAddressState(
          event.index,
          savedLocation: savedDeliveryLocation,
          locationList: event.addressList,
        ),
      );
    });

    on<OnButtonPressedAddressEvent>((event, emit) async {
      await addressBox.put('savedAddress', event.locationName);
      final String savedDeliveryLocation = addressBox.get('savedAddress');
      emit(
        OnButtonPressedState(
          state.selectedIndex,
          savedLocation: savedDeliveryLocation,
          locationList: state.locationList,
        ),
      );
    });
  }
}
