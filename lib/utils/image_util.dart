import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/utils/sqlite_util.dart';

class ImageUtil {
  ImageUtil._();

  ///使用image_picker从图库选择图片
  static Future<String?> openGallery() async {
    ImagePicker picker = ImagePicker();
    //从图库选择图片
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (null != image) {
      //使用选择的图片
      // print("选择的图片路径: ${image.path}");
      return image.path;
    } else {
      print("没有选择图片");
      return null;
    }
  }

  ///使用image_picker拍摄新照片
  static Future<String?> captureCamera() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (null != image) {
      //使用拍摄的照片
      // print("拍摄的照片路径:${image.path}");
      return image.path;
    } else {
      print("没有拍摄照片");
      return null;
    }
  }

  static void requestCamera(BuildContext context, {Function(String? result)? callback}) {
    final firstOpenCamera = SqliteUtil().getBool(CacheKey.firstOpenCamera) ?? true;
    if (firstOpenCamera) {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("当前应用想访问相机功能"),
          content: const Column(
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment(0, 0),
                child: Text("使用相机获取照片"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("不允许"),
            ),
            TextButton(
              onPressed: () {
                SqliteUtil().setBool(CacheKey.firstOpenCamera, false); //首次打开后，保存到本地
                Navigator.pop(context);
                _showActionSheet(context, callback: callback);
              },
              child: const Text("好"),
            ),
          ],
        ),
      );
    } else {
      _showActionSheet(context, callback: callback);
    }
  }

  static void _showActionSheet(BuildContext context, {Function(String? result)? callback}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              ImageUtil.captureCamera().then((value) => callback?.call(value));
              Navigator.pop(context);
            },
            child: const Text("打开相机"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              ImageUtil.openGallery().then((value) => callback?.call(value));
            },
            child: const Text("打开相册"),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }
}
