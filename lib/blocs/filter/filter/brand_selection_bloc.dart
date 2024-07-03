import 'package:amira_app/blocs/filter/brandSelection/brand_selection_bloc.dart';
import 'package:bloc/bloc.dart';

class BrandSelectionBloc
    extends Bloc<BrandSelectionEvent, BrandSelectionState> {
  int? _selectedBrandBottomSheet1;
  int? _selectedBrandBottomSheet2;

  BrandSelectionBloc() : super(const BrandSelectionInitial(-1, -1)) {
    on<SelectBrand>((event, emit) {
      if (event.bottomSheet == 1) {
        _selectedBrandBottomSheet1 = event.pressedBrandIndex;
      } else if (event.bottomSheet == 2) {
        _selectedBrandBottomSheet2 = event.pressedBrandIndex;
      }
      emit(
        BrandSelectionUpdated(
          _selectedBrandBottomSheet1 ?? -1,
          _selectedBrandBottomSheet2 ?? -1,
        ),
      );
    });

    on<ApplyBrandEvent>((event, emit) {
      if (event.bottomSheet == 1) {
        emit(
          BrandSelectionUpdated(
            _selectedBrandBottomSheet1 ?? -1,
            _selectedBrandBottomSheet1 ?? -1,
          ),
        );
      } else if (event.bottomSheet == 2) {
        emit(
          BrandSelectionUpdated(
            _selectedBrandBottomSheet2 ?? -1,
            _selectedBrandBottomSheet2 ?? -1,
          ),
        );
      }
    });
  }
}
