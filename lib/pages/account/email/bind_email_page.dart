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
      ],
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide()),
      ),
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          height: 42.h,
          decoration: BoxDecoration(
            color: const Color(0xff6C7A8F).withOpacity(0.24),
            borderRadius: BorderRadius.circular(36.r),
          ),
          child: inputTextEdit(
            hintText: "请输入邮箱账号",
            hintTextSize: 15,
            keyboardType: TextInputType.number,
            editController: controller.emailController,
          ),
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          height: 42.h,
          decoration: BoxDecoration(
            color: const Color(0xff6C7A8F).withOpacity(0.24),
            borderRadius: BorderRadius.circular(36.r),
          ),
          child: inputTextEdit(
            hintText: "请输入邮箱验证码",
            hintTextSize: 15,
            keyboardType: TextInputType.number,
            editController: controller.emailController,
          ),
        ),
      ],
    ).marginSymmetric(horizontal: 15.w);
  }
}
