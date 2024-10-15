import 'package:amira_app/data/api_providers/deliveryType_provider.dart';
import 'package:amira_app/data/models/deliveryType_model.dart';

class DeliveryRepository {
  final DeliveryTypeProvider deliveryProvider = DeliveryTypeProvider();
  Future<List<Row>> getDeliveryType() async {
    return deliveryProvider.getDeliveryType();
  }
}
