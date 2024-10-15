import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/deliveryType_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class DeliveryTypeProvider {
  Dio dio = Dio();
  final Box langBox = Hive.box('lang');

  Future<List<Row>> getDeliveryType() async {
    dio.options.headers = {
      'Accept-Language': langBox.get('lang') ?? 'tr',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      final Response response = await dio.get('${url}payments/delivery-types');
      if (response.statusCode == 200) {
        final List<dynamic> deliverData = response.data['data']['rows'];
        final List<Row> deliverTypes = deliverData
            .map(
              (e) => Row.fromJson(e),
            )
            .toList();
        return deliverTypes;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
