import 'package:amira_app/data/api_repositories/getAllCategories_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_category_event.dart';
part 'all_category_state.dart';

class AllCategoryBloc extends Bloc<AllCategoryEvent, AllCategoryState> {
  int page = 1;

  AllCategoryBloc() : super(AllCategoryInitial()) {
    final GetAllCategoriesRepository getAllCategoriesRepository =
        GetAllCategoriesRepository();

    on<GetAllCategoryList>((event, emit) async {
      emit(AllCategoryLoading());

      try {
        final categoryCount =
            await getAllCategoriesRepository.fetchCountCategory();
        if (categoryCount != null) {
          final allCategoryList = await getAllCategoriesRepository
              .fetchCategoryProductList(page: 1);
          emit(
            AllCategoryLoaded(
              allCategoryList: allCategoryList,
              categoryCount: categoryCount,
            ),
          );
        }
      } catch (e) {
        emit(AllCategoryError(error: e.toString()));
      }
    });
  }
}
