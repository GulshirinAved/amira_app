import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/getOneCataloge_model.dart';
import 'package:dio/dio.dart';

class GetOneCatalogeProvider {
  Dio dio = Dio();

  Future<Data> getOneCataloge(String id) async {
    final String allProductsUrl = '${url}category/$id';

    try {
      final Response response = await dio.get(allProductsUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data['data'];
        final Data product = Data.fromJson(responseData);
        print(product.subcategories);
        return product;
      } else {
        throw Exception('Failed to load catalog');
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
