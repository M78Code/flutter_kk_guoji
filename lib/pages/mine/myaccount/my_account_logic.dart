import 'package:get/get.dart';
import 'package:kkguoji/common/models/pair.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/utils/sqlite_util.dart';

class MyAccountLogic extends GetxController {
  //选中的下标
  RxInt selectedIndex = 0.obs;

  //用于观察选择的图片
  RxString selectedImg = Assets.avatar1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final saveAvatar = SqliteUtil().getString(CacheKey.defaultAvatar);
    if (null != saveAvatar) {
      selectedImg.value = saveAvatar;
    }
    final saveIndex = SqliteUtil().getInt(CacheKey.selectAvatarIndex);
    if (null != saveIndex) {
      selectedIndex.value = saveIndex;
    } else {
      selectedIndex.value = -1;
    }
    if (null == saveIndex && null == saveAvatar) {
      selectedIndex = 0.obs;
    }
  }

  ///通过默认图片列表选择图像
  void updateIndex(int index) {
    selectedIndex.value = index;
    selectedImg.value = avatarList[index].third;
    SqliteUtil().setInt(CacheKey.selectAvatarIndex, index);
    SqliteUtil().setString(CacheKey.defaultAvatar, avatarList[index].third);
  }

  ///通过相册选择图像
  void updateCamera(String? result) {
    if (null != result) {
      SqliteUtil().remove(CacheKey.selectAvatarIndex);
      SqliteUtil().setString(CacheKey.defaultAvatar, result);
      selectedImg.value = result;
      selectedIndex.value = -1;
    }
  }

  List<TPair<int, bool, String>> avatarList = [
    TPair(0, true, Assets.avatar1),
    TPair(1, false, Assets.avatar2),
    TPair(2, false, Assets.avatar3),
    TPair(3, false, Assets.avatar4),
    TPair(4, false, Assets.avatar5),
    TPair(5, false, Assets.avatar6),
    TPair(6, false, Assets.avatar7),
    TPair(7, false, Assets.iconCamera),
  ];
}
