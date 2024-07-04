import 'package:amira_app/data/api_providers/getallProducts_provider.dart';

class GetAllProductsRepository {
  final GetAllProductsProvider _getAllProductsProvider =
      GetAllProductsProvider();
  Future<List<dynamic>> fetchAllProductList(
    Map<String, dynamic> postData,
  ) async {
    return _getAllProductsProvider.fetchAllProducts(postData);
  }
}
