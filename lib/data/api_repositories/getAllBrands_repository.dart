import 'package:amira_app/data/api_providers/getAllBrands_provider.dart';

class GetAllBrandsRepository {
  final GetAllBrandsProvider _getAllBrandsProvider = GetAllBrandsProvider();
  Future<List<dynamic>> fetchAllBrandsList({String? categoryId}) async {
    return _getAllBrandsProvider.getAllBrands(categoryId: categoryId);
  }
}
