import 'dart:convert';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class GetAllProductsProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');

  Future<List<dynamic>> fetchAllProducts(Map<String, dynamic> postData) async {
    const String allProductsUrl = '${url}products/all';
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      final Response response =
          await dio.post(allProductsUrl, data: json.encode(postData));
      if (response.statusCode == 201) {
        final List<dynamic> products =
            response.data['data']['rows'].map((e) => Row.fromJson(e)).toList();

        return products;
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }
}
