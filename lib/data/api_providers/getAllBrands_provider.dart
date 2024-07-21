import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/brand_model.dart';
import 'package:dio/dio.dart';

class GetAllBrandsProvider {
  Dio dio = Dio();
  Future<List<Row>> getAllBrands({String? categoryId}) async {
    final String getAllBrandsUrl =
        '${url}category/brands?categoryId=$categoryId';
    try {
      final Response response = await dio.get(getAllBrandsUrl);
      if (response.statusCode == 200) {
        final List<dynamic> brandsData = response.data['data']['rows'];
        final List<Row> brands = brandsData
            .map(
              (e) => Row.fromJson(e),
            )
            .toList();
        return brands;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
