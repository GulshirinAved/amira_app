import 'dart:convert';

import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/api_providers/auth_provider.dart';
import 'package:dio/dio.dart';

class CreateOrderProvider {
  Dio dio = Dio();
  Future<bool> createCartProduct(Map<String, dynamic> postData) async {
    const String createOrderUrl = '${url}orders/create';
    final headers = {
      'Authorization': 'Bearer ${AuthProvider().getAccessToken()}',
      'Cookie': 'i18n_redirected=ru',
    };
    try {
      final Response response = await dio.post(createOrderUrl,
          data: json.encode(postData), options: Options(headers: headers));

      print('${'it is postdata${postData}'}');
      if (response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
