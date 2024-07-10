import 'package:amira_app/data/api_providers/home_provider.dart';
import 'package:amira_app/data/models/home_model.dart';

class GetHomeRespoitory {
  final HomeProvider _getHomeProvider = HomeProvider();
  Future<List<dynamic>> fetchHomeBanner() async {
    return _getHomeProvider.fetchAllHomebanner();
  }

  Future<List<List<Row>>> fetchAllHomeProducts() async {
    return _getHomeProvider.fetchAllHomeProducts();
  }

  Future<List<Datum>> fetchAllHomeData() async {
    return _getHomeProvider.fetchAllHomeData();
  }
}
