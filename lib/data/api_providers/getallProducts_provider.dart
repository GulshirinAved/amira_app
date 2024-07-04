import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/product_model.dart';
import 'package:dio/dio.dart';

class GetAllProductsProvider {
  Dio dio = Dio();
  Future<List<dynamic>> fetchAllProducts(Map<String, dynamic> postData) async {
    final String allProductsUrl = '${url}products/all';
    try {
      final Response response = await dio.post(allProductsUrl, data: postData);
      if (response.statusCode == 201) {
        final List<dynamic> products =
            response.data['data']['rows'].map((e) => Row.fromJson(e)).toList();
        return products;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
