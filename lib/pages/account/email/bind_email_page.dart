import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/account/email/email_logic.dart';
import 'package:kkguoji/pages/recharge/widgets/ex_widgets.dart';
import 'package:kkguoji/widget/keyboard_dismissable.dart';

class BindEmailPage extends GetView<EmailLogic> {
  const BindEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EmailLogic(),
      id: "BindEmailPage",
      builder: (controller) => KeyboardDissmissable(
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
              "请绑定邮箱",
              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
          ),
          body: _buildView(),
        ),
      ),
    );
  }

  Widget _buildView() {
    return Column(
      children: [
        Divider(height: 1.h, color: Colors.white.withOpacity(0.06)),
        SizedBox(height: 25.h),
        _buildInputEmail(),
        SizedBox(height: 25.h),
        _buildInputCode(),
        SizedBox(height: 50.h),
        buttonSubmit(
          text: "立即绑定",
          height: 55,
          onPressed: () {
            // controller.recharge();
          },
        ).marginSymmetric(horizontal: 15.w),
      ],
    );
  }

  ///邮箱账号
  Widget _buildInputEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "邮箱账号",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 14.h),
        inputTextEdit(
          hintText: "请输入邮箱账号",
          hintTextSize: 15,
          maxLength: 48,
          keyboardType: TextInputType.emailAddress,
          editController: controller.emailController,
        ),
      ],
    ).marginSymmetric(horizontal: 15.w);
  }

  ///邮箱账号
  Widget _buildInputCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "验证码",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 14.h),
        inputTextEdit(
          hintText: "请输入邮箱验证码",
          hintTextSize: 15,
          keyboardType: TextInputType.emailAddress,
          editController: controller.codeController,
          rightWidget: TextButton(
            style: ButtonStyle(
              alignment: Alignment.centerRight,
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),

            ),
            onPressed: () => controller.sendCodeToEmail(),
            child: Obx(
              () => Text(
                controller.countdown.value > 0 ? "${controller.countdown.value} s" : "发送验证码",
                textAlign: TextAlign.end,
                style: TextStyle(color: const Color(0xff5D5FEF), fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ],
    ).marginSymmetric(horizontal: 15.w);
  }
}
