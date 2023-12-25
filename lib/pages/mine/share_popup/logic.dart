import 'package:get/get.dart';
import 'package:kkguoji/common/api/agent_api.dart';

import '../../promotion/model/promotion_model.dart';
import 'state.dart';

class SharePopupLogic extends GetxController {
  final SharePopupState state = SharePopupState();
  KKPromotionModel? promotionModel;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  fetchAgentTeam() async {
    promotionModel = await AgentApi.getAgentTeam();
    update(['pop']);
  }
}
