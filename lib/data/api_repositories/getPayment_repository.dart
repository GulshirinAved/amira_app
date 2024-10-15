import 'package:amira_app/data/api_providers/getPaymentType_provider.dart';
import 'package:amira_app/data/models/payment_model.dart';

class PaymentRepository {
  final GetPaymentProvider paymentProvider = GetPaymentProvider();
  Future<List<Rows>> getPayment() async {
    return paymentProvider.getPayment();
  }
}
