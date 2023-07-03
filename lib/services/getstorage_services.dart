import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  saveCredentials({
    required String id,
    required String username,
    required String password,
    required String firstname,
    required String lastname,
    required String image,
    required String address,
    required String contactno,
  }) {
    storage.write("id", id);
    storage.write("username", username);
    storage.write("password", password);
    storage.write("firstname", firstname);
    storage.write("lastname", lastname);
    storage.write("contactno", contactno);
    storage.write("image", image);
    storage.write("address", address);
  }

  removeStorageCredentials() {
    storage.remove("id");
    storage.remove("username");
    storage.remove("password");
    storage.remove("firstname");
    storage.remove("lastname");
    storage.remove("contactno");
    storage.remove("image");
    storage.remove("address");
  }
}
