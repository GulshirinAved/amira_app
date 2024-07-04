import 'package:amira_app/data/api_providers/getAllCategories_provider.dart';

class GetAllCategoriesRepository {
  final GetAllCategoriesProvider _getAllCategoriesProvider =
      GetAllCategoriesProvider();

  Future<List<dynamic>> fetchCategoryProductList({
    required int page,
  }) async {
    return _getAllCategoriesProvider.fetchAllCategories(
      page: page,
    );
  }

  Future<int?> fetchCountCategory() async {
    return _getAllCategoriesProvider.fetchCategoryCount();
  }
}
