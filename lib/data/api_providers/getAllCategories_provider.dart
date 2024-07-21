import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GetAllCategoriesProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');

  Future<List<Rows>> fetchAllCategories({required int page}) async {
    final String getAllCategoryUrl = '${url}category/?page=$page&pageSize=10';
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final Response response = await dio.get(
        getAllCategoryUrl,
      );
      if (response.statusCode == 200) {
        final List<dynamic> categoriesData = response.data['data']['rows'];
        final List<Rows> categories = categoriesData
            .map((categoryJson) => Rows.fromJson(categoryJson))
            .toList();

        return categories;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int?> fetchCategoryCount({required int page}) async {
    final String getAllCategoryUrl = '${url}category/?page=$page&pageSize=10';
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final Response response = await dio.get(getAllCategoryUrl);
      if (response.statusCode == 200) {
        final CategoryModel categoryModel =
            CategoryModel.fromJson(response.data);

        return categoryModel.data?.count;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
