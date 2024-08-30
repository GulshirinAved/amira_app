import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/getOneProduct_model.dart';
import 'package:dio/dio.dart';

class GetOneProductProvider {
  Dio dio = Dio();

  Future<Data> getOneProduct(String? id) async {
    final String allProductsUrl = '${url}products/$id';

    try {
      final Response response = await dio.get(allProductsUrl);
      print('it is id ${id}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data['data'];
        final Data product = Data.fromJson(responseData);
        return product;
      } else {
        throw Exception('Failed to load product');
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
