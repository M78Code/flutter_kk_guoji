import 'package:get/get.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';
import 'package:kkguoji/pages/message/message_model.dart';
import 'package:kkguoji/routes/routes.dart';

class MessageRequest extends GetxController {
  RxInt selectedCategoryId = 0.obs;

  ///消息中心
  List<String> messageSelectBar = ["全部活动", "通知活动", "系统公告"];
  late List<CategoryModel> selectBar = List.generate(messageSelectBar.length,
      (index) => CategoryModel(index: index, name: messageSelectBar[index]));

  List<MessageModel> messageList = [
    MessageModel(
        id: 0,
        title: '公告',
        link: "",
        content: '',
        image: '',
        create_time: '2023-24-29',
        is_read: 2),
  ];

  void onCategoryTap(int categoryId) {
    print(categoryId);
    selectedCategoryId.value = categoryId;
    update(["categoryView", "itemsView"]);
  }

  //获取公告列表
  void getMessageListData(int page) {
    print('什么鬼');
    Get.toNamed(
      Routes.getMessageList,
      arguments: {
        "type": selectedCategoryId.value + 1,
        "page": page,
        "limit": 10,
      },
    );
  }
}
