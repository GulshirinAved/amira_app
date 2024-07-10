import 'dart:convert';

import 'package:amira_app/config/constants/constants.dart';
import 'package:dio/dio.dart';

class CreateOrderProvider {
  Dio dio = Dio();
  Future<bool> createCartProduct(Map<String, dynamic> postData) async {
    const String createOrderUrl = '${url}orders/create';
    try {
      final Response response =
          await dio.post(createOrderUrl, data: json.encode(postData));
      print(postData);
      if (response.statusCode == 201) {
        return true;
      }
      print(postData);

      return false;
    } catch (e) {
      print(postData);

      throw Exception(e.toString());
    }
  }
}
