import 'package:get/get.dart';
import 'package:kkguoji/services/user_service.dart';

import '../../../common/api/account_api.dart';
import 'state.dart';

class InformationSettingsLogic extends GetxController {
  final InformationSettingsState state = InformationSettingsState();
  bool isChanged = false;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    UserService.to.fetchUserInfo();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  setIsChanged(bool isChanged) {
    this.isChanged = isChanged;
    if (isChanged) update(['updateBtn']);
  }

  Future<bool> updateContact(String? wechat,
      String? qq,
      String? skype,
      String? telegram,
      String? whatsapp) async {
     var result = await AccountApi.updateContact(wechat,qq,skype,telegram,whatsapp);
     if(result?["success"] == true) {
       return true;
     }
     return false;
  }
}
