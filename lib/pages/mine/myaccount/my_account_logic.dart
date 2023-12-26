import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/models/pair.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/myaccount/my_account_model.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/sqlite_util.dart';
import 'package:kkguoji/utils/string_util.dart';
import 'package:kkguoji/widget/show_toast.dart';

class MyAccountLogic extends GetxController {
  //选中的下标
  RxInt selectedIndex = 0.obs;
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

  showPassword(RxBool b) {
    b.value = !b.value;
    // psdObscure.value = !psdObscure.value;
  }

  inputPasswordValue(String password) {
    passwordText = password;
    // checkCanLogin();
  }

  inputConfirmPsdValue(String confirmText, bool isConfirm) {
    if (isConfirm) {
      confirmPsdText = confirmText;
    } else {
      newPsdText = confirmText;
    }
  }

  inputVerCodeValue(String code) {
    verCodeText = code;
    // checkCanLogin();
  }

  void modifyNiceName() {
    setModifyNice = !setModifyNice;
    update();
  }

  void modifyNickNameSubmit() async {
    final aws3 = await postAWSS3();
    final map = {
      "user_nick": nickController.text,
      "portrait": "",
    };
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
    String imagePath,
    String imageName,
  ) async {
    // var url = "https://s3.us-east-1.amzzonaws.com/testing-presigned-upload";
    // final request = http.MultipartRequest("POST", Uri.parse(url));
    // request.files.add(await MultipartFile.fromPath("file"), imagePath);
    // request.fileds.addAll({"key": imagePath.split("/").last, "acl": "public-read"});
    // await request.send();
    print("The request is send");
    // String uploadedImageUrl = await AmazonS3Cognito.uploadImage(
    //     _image.path, BUCKET_NAME, IDENTITY_POOL_ID);
    //Use the below code to upload an image to amazon s3 server
    //I advise using this method for image upload.
    // String uploadedImageUrl = await AmazonS3Cognito.upload(
    //   imagePath,
    //   CacheKey.BUCKET_NAME,
    //   CacheKey.IDENTITY_POOL_ID,
    //   imageName,
    //   AwsRegion.US_EAST_1,
    //   AwsRegion.AP_SOUTHEAST_1,
    // );
    final aws3 = await postAWSS3();

    // AmazonS3Cognito.upload(bucket, identity, region, subRegion, imageData)
  }

// void deleteImageFromAWSS3(String imageName) {
//   String result = AmazonS3Cognito.delete(
//     CacheKey.BUCKET_NAME,
//     CacheKey.IDENTITY_POOL_ID,
//     imageName,
//     folderInBucketWhereImgIsUploaded,
//     AwsRegion.US_EAST_1,
//     AwsRegion.AP_SOUTHEAST_1,
//   );
// }

  void uploadSingleImage() async {
    String bucketName = "test";
    String cognitoPoolId = "your pool id";
    String bucketRegion = "imageUploadRegion";
    String bucketSubRegion = "Sub region of bucket";

    //fileUploadFolder - this is optional parameter
    String fileUploadFolder = "folder inside bucket where we want file to be uploaded";

    String filePath = ""; //path of file you want to upload
    // ImageData imageData = ImageData("uniqueFileName", filePath,
    //     uniqueId: "uniqueIdToTrackImage", imageUploadFolder: fileUploadFolder);

    //result is either amazon s3 url or failure reason
    // String? result = await AmazonS3Cognito.upload(
    //     bucketName, cognitoPoolId, bucketRegion, bucketSubRegion, imageData,
    //     needMultipartUpload: true);
    // //once upload is success or failure update the ui accordingly
    // print(result);
  }

  String clipText(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((value) {
      ShowToast.showToast("复制成功");
    });
    return "";
  }

  //设置登录密码提交
  Future<bool> setPsdSubmit(bool isWithdrawPsd) async {
    if (isWithdrawPsd) {
      if (passwordText.isEmpty) {
        ShowToast.showToast("请输入提现密码");
        return false;
      }
      if (newPsdText.isEmpty) {
        ShowToast.showToast("请再次输入提现密码");
        return false;
      }
      if (passwordText != newPsdText) {
        ShowToast.showToast("两次密码不一致");
        return false;
      }
      var result = await HttpRequest.request(
        HttpConfig.setWithDrawPassword,
        method: "post",
        params: {"password": passwordText},
      );
      if (result["code"] == 200) {
        ShowToast.showToast("设置提现密码成功");
        RouteUtil.popView();
      } else {
        ShowToast.showToast(result["message"]);
      }
    } else {
      if (passwordText.isEmpty) {
        ShowToast.showToast("请输入原密码");
        return false;
      }
      if (newPsdText.isEmpty) {
        ShowToast.showToast("请输入新密码");
        return false;
      }
      if (!StringUtil.checkPsdRule(newPsdText)) {
        ShowToast.showToast("密码由数字、字母、构成,长度8-20");
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
      if (verCodeText.isEmpty) {
        ShowToast.showToast("请输入验证码");
        return false;
      }
      Map<String, dynamic> params = {
        "old_password": passwordText,
        "password": newPsdText,
        "code": verCodeText,
        "code_value": codeValue,
      };
      var result = await HttpRequest.request(HttpConfig.modifyPassword, method: "post", params: params);
      if (result["code"] == 200) {
        ShowToast.showToast("更新登录密码成功");
        SqliteUtil().clean();
        RouteUtil.pushToView(Routes.loginPage, offAll: true);
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
