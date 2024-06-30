import 'package:hive/hive.dart';

class AddressProvider {
  Box addressBox = Hive.box('addressBox');
  List fetchAddresses() {
    final List addressList =
        addressBox.isNotEmpty ? addressBox.get('addressBox') : [];
    return addressList;
  }
}
