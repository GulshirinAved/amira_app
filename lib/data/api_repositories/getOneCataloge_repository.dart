import 'package:amira_app/data/api_providers/getOneCataloge_provider.dart';
import 'package:amira_app/data/models/getOneCataloge_model.dart';

class GetOneCatalogeRepository {
  final GetOneCatalogeProvider _getOneCatalogeProvider =
      GetOneCatalogeProvider();
  Future<Data> getOneCataloge(
    final String id,
  ) async {
    return _getOneCatalogeProvider.getOneCataloge(id);
  }
}
