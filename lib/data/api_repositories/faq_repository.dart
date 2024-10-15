import 'package:amira_app/data/api_providers/faq_provider.dart';
import 'package:amira_app/data/models/faq_model.dart';

class FaqRepository {
  final FaqProvider faqProvider = FaqProvider();
  Future<List<Row>> getFaq() async {
    return faqProvider.getFaq();
  }
}
