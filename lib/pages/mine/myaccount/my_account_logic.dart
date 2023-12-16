import 'dart:convert';

import 'package:get/get.dart';
import 'package:kkguoji/common/models/pair.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/myaccount/my_account_model.dart';
import 'package:kkguoji/services/cache_key.dart';
import 'package:kkguoji/services/config.dart';
import 'package:kkguoji/services/http_service.dart';
import 'package:kkguoji/utils/sqlite_util.dart';

class MyAccountLogic extends GetxController {
  //选中的下标
  RxInt selectedIndex = 0.obs;

  //用于观察选择的图片
  RxString selectedImg = Assets.myaccountAvatar1.obs;

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
    String fileUploadFolder =
        "folder inside bucket where we want file to be uploaded";

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

}
