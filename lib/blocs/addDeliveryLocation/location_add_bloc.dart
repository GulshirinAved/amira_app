import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'location_add_event.dart';
part 'location_add_state.dart';

class LocationAddBloc extends Bloc<LocationAddEvent, LocationAddState> {
  LocationAddBloc()
      : super(
          LocationAddInitial(
            -1,
            savedLocation: '',
            locationList: const [],
          ),
        ) {
    on<SaveAddressEvent>((event, emit) async {
      final Box addressBox = await Hive.openBox('addressBox');
      final List<String> currentList = List<String>.from(
          addressBox.get('addressList', defaultValue: <String>[]));
      currentList.add(event.locationName!);
      await addressBox.put('addressList', currentList);
      final String savedLocation =
          addressBox.get('savedAddress', defaultValue: <String>[]);
      emit(
        SaveAddressState(
          -1,
          savedLocation: savedLocation,
          locationList: currentList,
        ),
      );
    });

    on<ShowSavedAddressEvent>((event, emit) async {
      final updatedList = List<String>.from(state.locationList)
        ..add(event.locationName!);
      emit(
        SaveAddressState(
          -1,
          savedLocation: event.locationName!,
          locationList: updatedList,
        ),
      );
    });

    on<LoadAddressEvent>((event, emit) async {
      final Box addressBox = await Hive.openBox('addressBox');
      final List<String> addresses = List<String>.from(
        addressBox.get('addressList', defaultValue: <String>[]),
      );
      final String savedDeliveryLocation = addressBox.get('savedAddress');
      emit(
        SaveAddressState(
          -1,
          savedLocation: savedDeliveryLocation,
          locationList: addresses,
        ),
      );
    });

    on<SelectAddressEvent>((event, emit) async {
      final Box addressBox = await Hive.openBox('addressBox');
      final String savedDeliveryLocation = addressBox.get('savedAddress');
      emit(
        SaveAddressState(
          event.index,
          savedLocation: savedDeliveryLocation,
          locationList: event.addressList,
        ),
      );
    });

    on<OnButtonPressedAddressEvent>((event, emit) async {
      final Box addressBox = await Hive.openBox('addressBox');

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
