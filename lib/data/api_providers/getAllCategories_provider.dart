import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GetAllCategoriesProvider {
  Dio dio = Dio();
  Box categoryBox = Hive.box('categoryBox');
  Future<List<dynamic>> fetchAllCategories({required int page}) async {
    final String getAllCategoryUrl = '${url}category/?page=$page&pageSize=10';
    try {
      if (categoryBox.isEmpty) {
        final Response response = await dio.get(getAllCategoryUrl);
        if (response.statusCode == 200) {
          final List<dynamic> categoriesData = response.data['data']['rows'];
          final List<dynamic> categories = categoriesData
              .map((categoryJson) => Row.fromJson(categoryJson))
              .toList();
          final List<dynamic> serializedCategoryList =
              categories.map((e) => e.toJson()).toList();
          await categoryBox.addAll(serializedCategoryList);
          final List<dynamic> cachedCategoryList = categoryBox.values
              .map(
                (e) => Row.fromJson(e),
              )
              .toList();

          return cachedCategoryList;
        } else {
          return [];
        }
      } else {
        final List<dynamic> cachedCategoryList = categoryBox.values
            .map(
              (e) => Row.fromJson(e),
            )
            .toList();
        return cachedCategoryList;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int?> fetchCategoryCount() async {
    const String getAllCategoryUrl = '${url}category/?page=1&pageSize=10';

    try {
      final Response response = await dio.get(getAllCategoryUrl);
      if (response.statusCode == 200) {
        // Decode the response into a CategoryModel
        final CategoryModel categoryModel =
            CategoryModel.fromJson(response.data);

        // Return the 'count' value if available
        return categoryModel.data?.count;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
