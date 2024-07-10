import 'package:amira_app/data/api_providers/getOneProduct_provider.dart';
import 'package:amira_app/data/models/getOneProduct_model.dart';

class GetOneProductRepository {
  final GetOneProductProvider _getOneProductProvider = GetOneProductProvider();
  Future<Data> getOneProductRepository(
    final String id,
  ) async {
    return _getOneProductProvider.getOneProduct(id);
  }
}
