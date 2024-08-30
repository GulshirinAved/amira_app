import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:amira_app/data/models/allOrders_model.dart';
import 'package:dio/dio.dart';

class AllOrdersProvider {
  Dio dio = Dio();
  Future<List<Row>> getAllOrders({int? page}) async {
    final headers = {
      'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
      'Cookie': 'i18n_redirected=ru',
    };
    final getAllOrdersUrl =
        '${url}orders/all?page=$page&pageSize=15&status=completed';
    try {
      final Response response = await dio.get(
        getAllOrdersUrl,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        final List<dynamic> ordersList = response.data['data']['rows'];
        final List<Row> orders = ordersList
            .map(
              (e) => Row.fromJson(e),
            )
            .toList();
        return orders;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
