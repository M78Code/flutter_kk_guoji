import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/utils/sqlite_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as cp_im;

///https://blog.csdn.net/tianzhilan0/article/details/108145569

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

  //将图片写入file
  static Future<File> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    return File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
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

  /// 图片压缩 File -> File
  static Future<File?> fileCompressFile(File file) async {
    if (file.lengthSync() < 200 * 1024) {
      return file;
    }
    var quality = 100;
    if (file.lengthSync() > 4 * 1024 * 1024) {
      quality = 50;
    } else if (file.lengthSync() > 2 * 1024 * 1024) {
      quality = 60;
    } else if (file.lengthSync() > 1 * 1024 * 1024) {
      quality = 70;
    } else if (file.lengthSync() > 0.5 * 1024 * 1024) {
      quality = 80;
    } else if (file.lengthSync() > 0.25 * 1024 * 1024) {
      quality = 90;
    }
    var dir = await getTemporaryDirectory();
    var targetPath = "${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 600,
      quality: quality,
      rotate: 0,
    );

    print("压缩后：${file.lengthSync() / 1024}");

    // print("压缩后：${result?.lengthSync() / 1024}");

    return File(result?.path ?? "");
  }

  /// 图片压缩 File -> Uint8List
  static Future<Uint8List?> fileCompressUint8List(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    print(file.lengthSync());
    print(result?.length);
    return result;
  }

  /// 图片压缩 Asset -> Uint8List
  static Future<Uint8List?> imageCompressUint8List(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );

    return list;
  }

  /// 图片压缩 Uint8List -> Uint8List
  static Future<Uint8List> uint8ListCompressUint8List(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    print(list.length);
    print(result.length);
    return result;
  }

  static Future<File> compressAndSaveImage(File file) async {
    // 读取图片文件
    Uint8List imageBytes = await file.readAsBytes();

    // 将字节流解码为图像
    cp_im.Image? image = cp_im.decodeImage(imageBytes);

    if (image != null) {
      // 限制图片的宽高
      int maxWidth = 800; // 设定最大宽度
      int maxHeight = 600; // 设定最大高度

      // 根据最大宽高比例缩放图片
      cp_im.Image resizedImage = cp_im.copyResize(
        image,
        width: image.width > maxWidth ? maxWidth : image.width,
        height: image.height > maxHeight ? maxHeight : image.height,
      );

      // 将压缩后的图像保存到临时文件中
      File compressedImageFile = File('${file.parent.path}/compressed_image.jpg')
        ..writeAsBytesSync(
          cp_im.encodeJpg(resizedImage, quality: 85),
        ); // 85 是图片质量，可根据需求调整

      return compressedImageFile;
    } else {
      throw Exception('无法解码图像');
    }
  }

  static Future<String> compressImgAndPath(String imgPath) async {
    final file = File(imgPath);
    // 读取图片文件
    Uint8List imageBytes = await file.readAsBytes();
    cp_im.Image? tImage = cp_im.decodeNamedImage(imgPath, imageBytes);
    if (tImage != null) {
      // 限制图片的宽高
      int maxWidth = 800; // 设定最大宽度
      int maxHeight = 600; // 设定最大高度

      // 根据最大宽高比例缩放图片
      cp_im.Image resizedImage = cp_im.copyResize(
        tImage,
        width: tImage.width > maxWidth ? maxWidth : tImage.width,
        height: tImage.height > maxHeight ? maxHeight : tImage.height,
      );

      // 将压缩后的图像保存到临时文件中
      File compressedImageFile = File('${file.parent.path}/compressed_image.jpg')
        ..writeAsBytesSync(
          cp_im.encodeJpg(resizedImage, quality: 85),
        ); // 85 是图片质量，可根据需求调整
      return compressedImageFile.path;
    } else {
      throw Exception('无法解码图像');
    }
  }
}
