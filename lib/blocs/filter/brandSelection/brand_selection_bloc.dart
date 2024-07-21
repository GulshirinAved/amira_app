import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'brand_selection_event.dart';
part 'brand_selection_state.dart';

class BrandSelectionBloc
    extends Bloc<BrandSelectionEvent, BrandSelectionState> {
  List<Map<String, dynamic>> _selectedBrandBottomSheet1 = [];
  List<Map<String, dynamic>> _selectedBrandBottomSheet2 = [];

  BrandSelectionBloc() : super(const BrandSelectionInitial([], [])) {
    on<SelectBrand>((event, emit) {
      List<Map<String, dynamic>> selectedList = event.bottomSheet == 1
          ? _selectedBrandBottomSheet1
          : _selectedBrandBottomSheet2;

      int index = selectedList.indexWhere((brand) =>
          brand['name'] == event.pressedBrandName &&
          brand['brandId'] == event.brandId);

      if (index != -1) {
        selectedList.removeAt(index);
      } else {
        selectedList
            .add({'name': event.pressedBrandName, 'brandId': event.brandId});
      }

      emit(BrandSelectionUpdated(
        List.from(_selectedBrandBottomSheet1),
        List.from(_selectedBrandBottomSheet2),
      ));
    });

    on<ApplyBrandEvent>((event, emit) {
      if (event.bottomSheet == 1) {
        _selectedBrandBottomSheet2 = List.from(_selectedBrandBottomSheet1);
      } else {
        _selectedBrandBottomSheet1 = List.from(_selectedBrandBottomSheet2);
      }
      emit(BrandSelectionUpdated(
        List.from(_selectedBrandBottomSheet1),
        List.from(_selectedBrandBottomSheet2),
      ));
    });

    on<ClearBrandEvent>((event, emit) {
      _selectedBrandBottomSheet1.clear();
      _selectedBrandBottomSheet2.clear();
      emit(
        BrandSelectionUpdated(
          List.from(_selectedBrandBottomSheet1),
          List.from(_selectedBrandBottomSheet2),
        ),
      );
    });
  }
}
