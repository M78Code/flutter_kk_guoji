import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/myaccount/my_account_logic.dart';
import 'package:kkguoji/pages/recharge/widgets/ex_widgets.dart';
import 'package:kkguoji/widget/custom_input_field.dart';
import 'package:kkguoji/widget/keyboard_dismissable.dart';

class SetLoginPsdPage extends GetView {
  const SetLoginPsdPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("传过来的参数:${Get.arguments}");
    return GetBuilder(
      init: MyAccountLogic(),
      builder: (controller) {
        return KeyboardDissmissable(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Image.asset(
                  Assets.imagesBackNormal,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              title: Text(
                Get.arguments ? "提现密码" : "登录密码",
                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
            ),
            // body: Center(),
            body: Center(
              child: ListView(
                children: [
                  SizedBox(height: 20.h),
                  Obx(() {
                    return CustomInputField(Get.arguments ? Assets.myaccountIconFormInput : Assets.imagesPasswordIcon, "请输入原密码",
                        isObscureText: controller.psdObscure1.value,
                        rightWidget: GestureDetector(
                          child: SizedBox(
                            width: 60,
                            child: Image.asset(
                              controller.psdObscure1.value ? Assets.imagesPasswordOn : Assets.imagesPasswordOff,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          onTap: () {
                            controller.showPassword(controller.psdObscure1);
                          },
                        ),
                        valueChanged: (value) => controller.inputPasswordValue(value));
                  }),
                  SizedBox(height: 20.h),
                  Obx(() {
                    return CustomInputField(Get.arguments ? Assets.myaccountIconFormInput : Assets.imagesPasswordIcon, "请输入新密码",
                        isObscureText: controller.psdObscure2.value,
                        rightWidget: GestureDetector(
                          child: SizedBox(
                            width: 60,
                            child: Image.asset(
                              controller.psdObscure2.value ? Assets.imagesPasswordOn : Assets.imagesPasswordOff,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          onTap: () {
                            controller.showPassword(controller.psdObscure2);
                          },
                        ),
                        valueChanged: (value) => controller.inputConfirmPsdValue(value, false));
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    return CustomInputField(Get.arguments ? Assets.myaccountIconFormInput : Assets.imagesPasswordIcon, "请确认新密码",
                        isObscureText: controller.psdObscure3.value,
                        rightWidget: GestureDetector(
                          child: SizedBox(
                            width: 60,
                            child: Image.asset(
                              controller.psdObscure3.value ? Assets.imagesPasswordOn : Assets.imagesPasswordOff,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          onTap: () {
                            controller.showPassword(controller.psdObscure3);
                          },
                        ),
                        valueChanged: (value) => controller.inputConfirmPsdValue(value, true));
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    return CustomInputField(Assets.imagesVerCode, "请输入验证码", valueChanged: (value) {
                      controller.inputVerCodeValue(value);
                    },
                        rightWidget: GestureDetector(
                          child: SizedBox(
                              width: 80,
                              child: Center(
                                child: controller.verCodeImageBytes.value.isEmpty
                                    ? Container()
                                    : Image.memory(
                                        Uint8List.fromList(controller.verCodeImageBytes.value),
                                        width: 60,
                                      ),
                              )),
                          onTap: () {
                            controller.getVerCode();
                          },
                        ));
                  }),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Image.asset(Assets.imagesTipStar, width: 9.w, height: 22.h).marginOnly(right: 5.w),
                      Text(
                        "注意: 如忘记原密码，请联系客服",
                        style: TextStyle(color: const Color(0xffA19DBD), fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  buttonSubmit(
                    height: 50.h,
                    onPressed: () => controller.setPsdSubmit(Get.arguments),
                    text: "提交",
                  ),
                ],
              ).paddingSymmetric(horizontal: 15.w),
            ),
          ),
        );
      },
    );
  }
}
