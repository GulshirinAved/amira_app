import 'package:amira_app/data/api_providers/getAllCategories_provider.dart';
import 'package:amira_app/data/models/category_model.dart';

class GetAllCategoriesRepository {
  final GetAllCategoriesProvider _getAllCategoriesProvider =
      GetAllCategoriesProvider();

  Future<List<Rows>> fetchCategoryProductList({
    required int page,
  }) async {
    return _getAllCategoriesProvider.fetchAllCategories(
      page: page,
    );
  }

  Future<int?> fetchCountCategory({
    required int page,
  }) async {
    return _getAllCategoriesProvider.fetchCategoryCount(page: page);
  }
}
