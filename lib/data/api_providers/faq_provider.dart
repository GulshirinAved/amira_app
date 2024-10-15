import 'package:amira_app/config/constants/constants.dart';
import 'package:amira_app/data/models/faq_model.dart';
import 'package:dio/dio.dart';

class FaqProvider {
  Dio dio = Dio();
  Future<List<Row>> getFaq() async {
    const String faqUrl = '${url}api/faq-all';
    try {
      final Response response = await dio.get(faqUrl);
      if (response.statusCode == 200) {
        final List data = response.data['data']['rows'];

        final List<Row> faqList = data.map((e) => Row.fromJson(e)).toList();
        return faqList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
