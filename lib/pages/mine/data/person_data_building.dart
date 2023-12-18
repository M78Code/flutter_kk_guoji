
import 'package:get/get.dart';
import 'package:kkguoji/pages/mine/data/personal_data_logic.dart';

class PersonalDataBinding extends Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> PersonalDataLogic());

  }
}