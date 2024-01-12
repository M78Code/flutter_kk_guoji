import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/api/account_api.dart';
import 'package:kkguoji/common/models/pair.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/myaccount/my_account_model.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/image_util.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/sqlite_util.dart';
import 'package:kkguoji/widget/show_toast.dart';

class WithdrawPsdLogic extends GetxController {
  //选中的下标
  RxInt selectedIndex = 99.obs;
  final RxBool psdObscure1 = true.obs;
  final RxBool psdObscure2 = true.obs;
  final RxBool psdObscure3 = true.obs;
  final RxBool isModifyNickName = false.obs; //修改昵称
  bool setModifyNice = false;
  String passwordText = "";
  String newPsdText = "";
  String confirmPsdText = "";
  String verCodeText = "";
  String codeValue = "";

  final RxList<int> verCodeImageBytes = RxList<int>();
  final nickController = TextEditingController();

  //用于观察选择的图片
  RxString selectedImg = Assets.myaccountAvatar1.obs;
  final userService = Get.find<UserService>();
  UserInfoModel? userInfoModel; //用户信息类

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userInfoModel = userService.userInfoModel.value;
    getVerCode();
    // final saveAvatar = SqliteUtil().getString(CacheKey.defaultAvatar);
    // if (null != saveAvatar) {
    //   selectedImg.value = saveAvatar;
    // }
    final saveIndex = SqliteUtil().getInt(CacheKey.selectAvatarIndex);
    if (null != saveIndex) {
      selectedIndex.value = saveIndex;
    } else {
      selectedIndex.value = -1;
    }
    // if (null == saveIndex && null == saveAvatar) {
    //   selectedIndex = 0.obs;
    // }
  }

  showPassword(RxBool b) {
    b.value = !b.value;
    // psdObscure.value = !psdObscure.value;
  }

  inputPasswordValue(String password, int flag) {
    if (flag == 0) {
      passwordText = password;
    } else if (flag == 1) {
      newPsdText = password;
    } else if (flag == 2) {
      confirmPsdText = password;
    } else {
      passwordText = password;
    }
  }

  inputVerCodeValue(String code) {
    verCodeText = code;
  }

  void modifyNiceName() {
    setModifyNice = !setModifyNice;
    update();
  }

  void getVerCode() async {
    codeValue = getVerify(6);
    var result = await HttpRequest.request(HttpConfig.getCode, method: "get", params: {"code_value": codeValue});
    verCodeImageBytes.value = result;
  }

  String getVerify(int length) {
    String code = "";
    String str = "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    List strList = str.split("");
    for (int i = 0; i < length; i++) {
      Random random = Random.secure();
      code += strList[random.nextInt(str.length)];
    }
    return code;
  }

  ///通过默认图片列表选择图像
  void updateIndex(int index) {
    Get.arguments["urlPath"] = "";
    selectedIndex.value = index;
    selectedImg.value = avatarList[index].third;
    SqliteUtil().setInt(CacheKey.selectAvatarIndex, index);
    // SqliteUtil().setString(CacheKey.defaultAvatar, avatarList[index].third);
  }

  ///通过相册选择图像
  void updateCamera(String? result) async {
    if (null != result) {
      SqliteUtil().remove(CacheKey.selectAvatarIndex);
      // SqliteUtil().setString(CacheKey.defaultAvatar, result);
      selectedImg.value = result;
      selectedIndex.value = -1;
    }
  }

  List<TPair<int, bool, String>> avatarList = [
    TPair(0, true, Assets.myaccountAvatar1),
    TPair(1, false, Assets.myaccountAvatar2),
    TPair(2, false, Assets.myaccountAvatar3),
    TPair(3, false, Assets.myaccountAvatar4),
    TPair(4, false, Assets.myaccountAvatar5),
    TPair(5, false, Assets.myaccountAvatar6),
    TPair(6, false, Assets.myaccountAvatar7),
    TPair(7, false, Assets.myaccountIconCamera),
  ];

  Future<AwsS3Model?> postAWSS3() async {
    final response = await HttpRequest.request(
      HttpConfig.uploadImage,
      method: "post",
      params: {"type": "image/*"},
    );
    final result = response["data"];
    return AwsS3Model.fromJson(result);
  }

  ///图片上传
  void uploadImageFromAWSS3(
    String? imagePath,
    String? imageName,
  ) async {
    // var url = "https://s3.us-east-1.amzzonaws.com/testing-presigned-upload";
    // final request = http.MultipartRequest("POST", Uri.parse(url));
    // request.files.add(await http.MultipartFile.fromPath("file", imagePath!), imagePath);
    // request.fileds.addAll({"key": imagePath.split("/").last, "acl": "public-read"});
    // await request.send();
    // const _accessKeyId = 'AKXXXXXXXXXXXXXXXXXX';
    // const _secretKeyId = 'xxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxx';
    // const _region = 'ap-southeast-1';
    // const _s3Endpoint = 'https://bucketname.s3-ap-southeast-1.amazonaws.com';
    // final rBundle = await rootBundle.loadString(Assets.gamesGamesLotteryArrow);
    // final file = File(rBundle);
    // final stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    // final length = await file.length();
    // final uri = Uri.parse(_s3Endpoint);
    // final req = http.MultipartRequest("POST", uri);
    // final multipartFile = http.MultipartFile('file', stream, length, filename: path.basename(file.path));
    // final policy = AwsPolicy.fromS3PresignedPost('uploaded/square-cinnamon.jpg', 'bucketname', _accessKeyId, 15, length, region: _region);
    // final key = SigV4.calculateSigningKey(_secretKeyId, policy.datetime, _region, 's3');
    // final signature = SigV4.calculateSignature(key, policy.encode());
    // req.files.add(multipartFile);
    // req.fields['key'] = policy.key;
    // req.fields['acl'] = 'public-read';
    // req.fields['X-Amz-Credential'] = policy.credential;
    // req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    // req.fields['X-Amz-Date'] = policy.datetime;
    // req.fields['Policy'] = policy.encode();
    // req.fields['X-Amz-Signature'] = signature;
    // try {
    //   final res = await req.send();
    //   await for (var value in res.stream.transform(utf8.decoder)) {
    //     print(value);
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }

    // AmazonS3Cognito.upload(bucket, identity, region, subRegion, imageData)
  }

  void updateNickAndAvatar() async {
    if (setModifyNice && nickController.text.isEmpty) {
      ShowToast.showToast("请设置用户昵称");
      return;
    }

    try {
      bool response;
      if (selectedImg.value.startsWith("http")) {
        response = await AccountApi.updateUserInfo({
          "user_nick": Get.arguments["nick"],
          "portrait": selectedImg.value,
        });
      } else {
        final file = await ImageUtil.getImageFileFileFromAssets(selectedImg.value);
        final compressFile = await ImageUtil.compressAndSaveImage(file);
        final value = await AccountApi.uploadImage(compressFile.path);
        response = await AccountApi.updateUserInfo({
          "user_nick": Get.arguments["nick"],
          "portrait": value?.url,
        });
      }

      if (response) {
        ShowToast.showToast("更新成功");
        userInfoModel = await AccountApi.getUserInfo();
      } else {
        ShowToast.showToast("更新失败");
      }
    } catch (e) {
      print(e);
    }

    // updateUserInfo

    // const url = "https://s3.us-east-1.amzzonaws.com/testing-presigned-upload";
    // ByteData imageData = await rootBundle.load(Assets.activityActivity);
    // Uint8List bytes = imageData.buffer.asUint8List();

    //创建一个临时文件来存储图片数据
    // final result = await AwsS3.uploadFile(
    //   accessKey: "AKxxxxxxxxxxxxx",
    //   secretKey: "xxxxxxxxxxxxxxxxxxxxxxxxxx",
    //   bucket: "bucket_name",
    //   file: File("/Users/lind/LeonProject/kkguoji/assets/images/activity/activity.png"),
    // );
    // print("result = $result");
    // String tempPath = await getTemporaryDirectory();
    // DefaultAssetBundle.of(context).loadString(Assets.activityActivity);
    // File f2 = File(rBundle);
    // final f2f = await f2.exists();
    // print("f2f = $bytes");

    //  File file = File("/Users/lind/LeonProject/kkguoji/assets/images/activity/activity.png");
    //  final form = leonForm.FormData.fromMap(
    //    {
    //      "file": leonFile.MultipartFile.fromString(file.path, filename: "avatar.jpg"),
    //    },
    //  );
    // final response = await Dio().post(url, data: form);
    //  print("response : $response");
    // final file = await StringUtil.getLocalSupportFile(Assets.activityActivity);

    // File file = File(rBundle);
    // final isExist = await file.exists();
    // print("isExist = $isExist");
    // final request = http.MultipartRequest("POST", Uri.parse(url));
    // //添加图片作为文件
    // final stream = http.ByteStream(file.openRead());
    // print("stream ---stream");
    // final length = await file.length();
    // final multipartFile = http.MultipartFile(
    //   "nickAvatar", stream, length, filename: path.basename(file.path), //文件名
    // );
    // //添加文件到请求中
    // request.files.add(multipartFile);
    // //发送请求
    // final response = await http.Response.fromStream(await request.send());
    // if (response.statusCode == 200) {
    //   print("上传成功");
    // } else {
    //   print("上传失败: ${response.statusCode}");
    // }
  }

  /*Future uploadMultipleImage(List<File> img) async {
    var uri = Uri.parse("https://s3.us-east-1.amzzonaws.com/testing-presigned-upload");
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    // List<MultipartFile> newList = [];
    for (int i = 0; i < img.length; i++) {
      File imageFile = File(img[i].path);
      var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile("file", stream, length, filename: path.basename(imageFile.path));
      print(imageFile.path);
      // newList.add(multipartFile);
      request.files.add(multipartFile);
    }
    // request.files.addAll(newList);
    // print(newList);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }*/

  String clipText(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((value) {
      ShowToast.showToast("复制成功");
    });
    return "";
  }

  //设置登录密码提交
  Future<bool> setPsdSubmit(bool isWithdrawPsd) async {
    if (isWithdrawPsd) {
      if (newPsdText.isEmpty) {
        ShowToast.showToast("请输入提现密码");
        return false;
      }
      if (confirmPsdText.isEmpty) {
        ShowToast.showToast("请再次输入提现密码");
        return false;
      }
      if (newPsdText != confirmPsdText) {
        ShowToast.showToast("两次密码不一致");
        return false;
      }
      var result = await HttpRequest.request(
        HttpConfig.setWithDrawPassword,
        method: "post",
        params: {"password": newPsdText},
      );
      if (result["code"] == 200) {
        ShowToast.showToast("设置提现密码成功");
        RouteUtil.popView();
      } else {
        ShowToast.showToast(result["message"]);
      }
    } else {
      if (passwordText.isEmpty) {
        ShowToast.showToast("请输入旧密码");
        return false;
      }
      if (newPsdText.isEmpty) {
        ShowToast.showToast("请输入新密码");
        return false;
      }
      if (confirmPsdText.isEmpty) {
        ShowToast.showToast("请确认新密码");
        return false;
      }
      if (newPsdText != confirmPsdText) {
        ShowToast.showToast("新密码不一致");
        return false;
      }
      Map<String, dynamic> params = {
        "old_password": passwordText,
        "password": newPsdText,
      };
      var result = await HttpRequest.request(HttpConfig.modifyWDPassword, method: "post", params: params);
      if (result["code"] == 200) {
        ShowToast.showToast("更新提现密码成功");
        RouteUtil.popView();
      } else {
        ShowToast.showToast(result["message"]);
      }
    }
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nickController.dispose();
    super.dispose();
  }
}
