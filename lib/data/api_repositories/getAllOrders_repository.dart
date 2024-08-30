import 'package:amira_app/data/api_providers/allOrders_provider.dart';
import 'package:amira_app/data/models/allOrders_model.dart';

class GetAllOrdersRepository {
  final AllOrdersProvider _getAllOrdersRepository = AllOrdersProvider();
  Future<List<Row>> fetchAllOrdersList({final int? page}) async {
    return _getAllOrdersRepository.getAllOrders(page: page);
  }
}
