import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/global.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';
import 'package:kkguoji/pages/recharge/widgets/ex_widgets.dart';
import 'package:kkguoji/pages/withdraw/withdraw_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/string_util.dart';
import 'package:kkguoji/widget/inkwell_view.dart';
import 'package:kkguoji/widget/keyboard_dismissable.dart';

class WithdrawPage extends GetView<WithdrawLogic> {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder(
      init: WithdrawLogic(),
      id: "WithdrawPage",
      builder: (controller) => KeyboardDissmissable(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: SafeArea(child: _buildView(context)),
        ),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          width: 1.h,
          color: Colors.white.withOpacity(0.06),
        ),
      )),
      child: ListView(
        children: [
          Text(
            "提现货币",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ).marginSymmetric(vertical: 10.h),
          _buildCoinCategory(),
          _buildUsableMoney().marginSymmetric(vertical: 15.h),
          Text(
            "选择网络",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          _buildSelectCategory().marginOnly(top: 18.h, bottom: 20.h),
          _buildInputName().marginOnly(bottom: 20.h),
          _buildInputCoinAddress().marginOnly(bottom: 20.h),
          _buildInputAmount().marginOnly(bottom: 20.h),
          _buildWithdrawPsd(),
          // _buildWarning().marginOnly(top: 10.h, bottom: 10.h),
          // _buildTip(),
          // _buildWithdrawInfo(),
          buttonSubmit(
            height: 50.h,
            text: "确认提现",
            onPressed: controller.isSubmit
                ? () => controller.withdrawSubmit().then((value) {
                      if (value) {
                        _showDialog(context);
                      }
                    })
                : null,
          ).marginSymmetric(vertical: 20.h),
        ],
      ).paddingSymmetric(horizontal: 20.w),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Image.asset(
          Assets.imagesBackNormal,
          width: 20.w,
          height: 20.h,
        ),
      ),
      title: Text(
        "提现",
        style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 25.w),
          child: Text(
            StringUtil.formatAmount(UserService.to.userMoneyModel?.money ?? "0.00"),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  ///选择类型Spinner
  Widget _buildSelectCategory() {
    return Obx(
      () {
        List<CategoryModel> selectOptions = controller.typeOptions;
        return Wrap(
          spacing: 20.w,
          runSpacing: 10.h,
          children: List.generate(
            selectOptions.length,
            (index) => CategoryRadioWidget(
              category: selectOptions[index],
              isSelected: controller.selectTypeIndex.value == selectOptions[index].index,
              onTap: (category) {
                controller.onSelectCategoryUpdate(category.index ?? 1);
              },
            ),
          ),
        );
      },
    );
  }

  ///提现货币类型Spinner
  Widget _buildCoinCategory() {
    return Obx(
      () => Wrap(
        spacing: 20.w,
        runSpacing: 15.h,
        children: List.generate(
          controller.options.length,
          (index) => CategoryRadioWidget(
            category: controller.options[index],
            isSelected: controller.coinCategoryIndex.value == controller.options[index].name,
            onTap: (category) {
              controller.onCoinCategoryUpdate(category);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUsableMoney() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.w),
      height: 42.h,
      decoration: BoxDecoration(
        color: const Color(0xff615998).withOpacity(0.24),
        borderRadius: BorderRadius.circular(36.r),
      ),
      child: Row(
        children: [
          Text(
            "余额",
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          SizedBox(width: 3.w),
          SizedBox(
            width: 30,
            height: 30,
            child: TextButton(
              onPressed: () async {
                controller.animationController
                  ..reset()
                  ..forward();
                controller.updateUserInfo();
              },
              style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              child: AnimatedBuilder(
                animation: controller.animationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: controller.rotationAnimation.value * (3.14 / 180), // 将度数转换为弧度
                    child: Image.asset(
                      Assets.imagesHomeRefreshIcon,
                      width: 18,
                      height: 18,
                      fit: BoxFit.fitWidth,
                    ),
                  );
                },
              ),
            ),
          ),
          // Image.asset(Assets.imagesIconRefresh, width: 14.w, height: 12.h),
          const Spacer(),
          Text(
            StringUtil.formatAmount(UserService.to.userMoneyModel?.money ?? "0.00"),
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          )
        ],
      ),
    );
  }

  ///收款账户
  Widget _buildInputName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "收款人姓名",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),
        inputTextEdit(
          hintText: "请输入收款人姓名（选填）",
          hintTextSize: 15,
          editController: controller.nameController,
        ),
      ],
    );
  }

  ///提币地址
  Widget _buildInputCoinAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "收款地址",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),
        inputTextEdit(
          hintText: "请输入USDT钱包地址",
          hintTextSize: 15,
          maxLength: 200,
          editController: controller.addressController,
        ),
      ],
    );
  }

  ///提款金额
  Widget _buildInputAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "提现金额",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),
        inputTextEdit(
          hintText: "请输入提现金额",
          hintTextSize: 15,
          keyboardType: TextInputType.number,
          editController: controller.amountController,
          callback: (value) => controller.calcAmount(),
        )
      ],
    );
  }

  ///提现密码
  Widget _buildWithdrawPsd() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "提现密码",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        if (controller.userInfoModel?.withdrawPwdStatus == 1) const SizedBox(height: 10),
        Obx(
          () => Visibility(
            visible: controller.userInfoModel?.withdrawPwdStatus == 1,
            child: inputTextEdit(
              hintText: "请输入提现密码",
              hintTextSize: 15,
              maxLength: 6,
              isPassword: controller.showPsd.value,
              keyboardType: TextInputType.number,
              callback: (value) => controller.calcAmount(),
              editController: controller.withdrawPsdController,
              rightWidget: IconButton(
                padding: EdgeInsets.zero, //设置内边距为零
                visualDensity: VisualDensity.compact,
                onPressed: () => controller.showPsd.value = !controller.showPsd.value,
                icon: Image.asset(
                  controller.showPsd.value ? Assets.imagesPasswordOn : Assets.imagesPasswordOff,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          ),
        ),
        if (controller.userInfoModel?.withdrawPwdStatus == 1) const SizedBox(height: 5),
        InkWellView(
          gradient: const LinearGradient(
            colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
          ),
          width: 100,
          height: 32,
          borderRadius: 16.0,
          onPressed: () async {
            var data = await Get.toNamed(
              Routes.withdrawPsd,
              arguments: controller.userInfoModel?.withdrawPwdStatus == 0,
            );
            if (data is UserInfoModel) {
              controller.updateUserInfo2(data);
            }
          },
          child: Text(
            controller.userInfoModel?.withdrawPwdStatus == 1 ? "修改提现密码" : "设置提现密码",
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ).marginSymmetric(vertical: 10.h),
        Row(
          children: [
            Image.asset(
              Assets.rechargeIconTip,
              width: 14.w,
              height: 14.h,
              color: const Color(0xffFF8A00),
            ),
            SizedBox(width: 5.w),
            Text(
              controller.userInfoModel?.withdrawPwdStatus == 1 ? "如您忘记提现密码，请联系客服处理。" : "为了您的账号安全，请设置提现密码。",
              style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 12.sp),
            ),
          ],
        )
      ],
    );
  }

  ///提示
  // Widget _buildTip() {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Image.asset(
  //             Assets.rechargeIconTip,
  //             width: 14.w,
  //             height: 14.h,
  //             color: const Color(0xffFF8A00),
  //           ),
  //           SizedBox(width: 6.w),
  //           Expanded(
  //             child: Text(
  //               "如您忘记提现密码，请联系客服处理！",
  //               style: TextStyle(color: Colors.white, height: 1.2, fontSize: 12.sp),
  //             ),
  //           ),
  //           InkWellView(
  //             onPressed: () => RouteUtil.pushToView(
  //               Routes.withdrawPsd,
  //               arguments: controller.userInfoModel?.withdrawPwdStatus == 0,
  //             ),
  //             child: Text(
  //               controller.userInfoModel?.withdrawPwdStatus == 0 ? "设置提现密码" : "更新提现密码",
  //               style: TextStyle(
  //                 fontSize: 13.sp,
  //                 color: const Color(0xff5D5FEF),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 25.h),
  //       Row(
  //         children: [
  //           Image.asset(Assets.rechargeIconTip, width: 14.w, height: 14.h),
  //           SizedBox(width: 5.w),
  //           Text(
  //             "最低提现金额不低于5.0 ¥",
  //             style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 12.sp),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 11.h),
  //       Row(
  //         children: [
  //           Image.asset(Assets.rechargeIconTip, width: 14.w, height: 14.h),
  //           SizedBox(width: 5.w),
  //           Text(
  //             "最高提现金额不高于80000.0 ¥",
  //             style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 12.sp),
  //           ),
  //         ],
  //       )
  //     ],
  //   ).marginSymmetric(vertical: 12.h);
  // }

  ///提现信息
  // Widget _buildWithdrawInfo() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 19.w),
  //     margin: EdgeInsets.only(top: 15.h, bottom: 29.h),
  //     height: 113.h,
  //     decoration: BoxDecoration(
  //       color: const Color(0xff6C7A8F).withOpacity(0.12),
  //       borderRadius: BorderRadius.circular(6.r),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Text(
  //                 "提款手续费",
  //                 style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 13.sp),
  //               ),
  //               Text(
  //                 "提款金额",
  //                 style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 13.sp),
  //               ),
  //               Text(
  //                 "预计到账时间",
  //                 style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 13.sp),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Text(
  //                 "2%",
  //                 style: TextStyle(color: Colors.white, fontSize: 13.sp),
  //               ),
  //               Obx(
  //                 () => Text(
  //                   "${controller.withTotalAmount.value} ¥",
  //                   style: TextStyle(color: Colors.white, fontSize: 13.sp),
  //                 ),
  //               ),
  //               Text(
  //                 "5分钟",
  //                 style: TextStyle(color: Colors.white, fontSize: 13.sp),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildWarning() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       InkWellView(
  //         gradient: const LinearGradient(
  //           colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
  //         ),
  //         width: 100,
  //         height: 32,
  //         borderRadius: 16.0,
  //         onPressed: () => RouteUtil.pushToView(
  //           Routes.withdrawPsd,
  //           arguments: controller.userInfoModel?.withdrawPwdStatus == 0,
  //         ),
  //         child: Text(
  //           controller.userInfoModel?.withdrawPwdStatus == 0 ? "提现密码" : "修改提现密码",
  //           style: TextStyle(
  //             fontSize: 12.sp,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ).marginOnly(top: 5, bottom: 10),
  //       Row(
  //         children: [
  //           Image.asset(
  //             Assets.rechargeIconTip,
  //             width: 14.w,
  //             height: 14.h,
  //             color: const Color(0xffFF8A00),
  //           ),
  //           SizedBox(width: 5.w),
  //           Text(
  //             "为了您的账号安全，请设置提现密码。",
  //             style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 12.sp),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  ///退出弹框
  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            backgroundColor: const Color(0xff181E2F),
            shadowColor: const Color(0xff2E374C),
            title: const Text(
              '提示',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              "提现成功，请等待提现到账",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  gradient: const LinearGradient(
                    colors: [Color(0xff3D35C6), Color(0xff6C4FE0)],
                  ),
                ),
                child: TextButton(
                    onPressed: () {
                      controller.clearInput();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '确认',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              )
            ],
          );
        });
  }
}
