import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';
import 'package:kkguoji/pages/recharge/widgets/ex_widgets.dart';
import 'package:kkguoji/pages/withdraw/withdraw_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';
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
          body: SafeArea(child: _buildView()),
        ),
      ),
    );
  }

  Widget _buildView() {
    return ListView(
      children: [
        Text(
          "提现货币",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ).marginOnly(top: 20.h, bottom: 15.h),
        _buildCoinCategory(),
        _buildUsableMoney().marginOnly(top: 18.h, bottom: 25.h),
        Text(
          "选择网络",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        _buildSelectCategory().marginOnly(top: 18.h, bottom: 25.h),
        _buildInputName().marginOnly(bottom: 25.h),
        _buildInputCoinAddress().marginOnly(bottom: 25.h),
        _buildInputAmount().marginOnly(bottom: 25.h),
        _buildWithdrawPsd(),
        _buildTip(),
        _buildWithdrawInfo(),
        buttonSubmit(
          height: 50.h,
          text: "确认提现",
          onPressed: () => controller.withdrawSubmit(),
        ),
        _buildWarning(),
      ],
    ).paddingSymmetric(horizontal: 20.w);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "¥",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                UserService.to.userMoneyModel?.money ?? "0.00",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
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
          runSpacing: 15.h,
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
              print("充值中选择的值:${category.name}");
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
          Image.asset(Assets.imagesIconRefresh, width: 14.w, height: 12.h),
          const Spacer(),
          Text(
            "${UserService.to.userMoneyModel?.money ?? 0.00} ¥",
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
        SizedBox(height: 14.h),
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
          "提币地址",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 14.h),
        inputTextEdit(
          hintText: "请输入USDT钱包提现地址",
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
          "提款金额",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 14.h),
        inputTextEdit(
          hintText: "请输入提款金额",
          hintTextSize: 15,
          keyboardType: TextInputType.number,
          editController: controller.amountController,
          callback: (value) => controller.calcAmount(value),
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
        SizedBox(height: 14.h),
        inputTextEdit(
          hintText: "请输入提现密码",
          hintTextSize: 15,
          keyboardType: TextInputType.number,
          editController: controller.withdrawPsdController,
          rightWidget: IconButton(
            padding: EdgeInsets.zero, // 设置内边距为零
            visualDensity: VisualDensity.compact,
            onPressed: () => controller.showPsd.value = !controller.showPsd.value,
            icon: Image.asset(
              controller.showPsd.value ? Assets.imagesPasswordOff : Assets.imagesPasswordOn,
              width: 24.w,
              height: 24.h,
            ),
          ),
        ),
      ],
    );
  }

  ///提示
  Widget _buildTip() {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.rechargeIconTip,
              width: 14.w,
              height: 14.h,
              color: const Color(0xffFF8A00),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                "如您忘记提现密码，请联系客服处理！",
                style: TextStyle(color: Colors.white, height: 1.2, fontSize: 12.sp),
              ),
            ),
            InkWellView(
              onPressed: () => RouteUtil.pushToView(Routes.setLoginPsdPage, arguments: true),
              child: Text(
                "更新提现密码",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xff5D5FEF),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 25.h),
        Row(
          children: [
            Image.asset(Assets.rechargeIconTip, width: 14.w, height: 14.h),
            SizedBox(width: 5.w),
            Text(
              "最低提现金额不低于5.0 ¥",
              style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(height: 11.h),
        Row(
          children: [
            Image.asset(Assets.rechargeIconTip, width: 14.w, height: 14.h),
            SizedBox(width: 5.w),
            Text(
              "最高提现金额不低于80000.0 ¥",
              style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 12.sp),
            ),
          ],
        )
      ],
    ).marginSymmetric(vertical: 12.h);
  }

  ///提现信息
  Widget _buildWithdrawInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.w),
      margin: EdgeInsets.only(top: 15.h, bottom: 29.h),
      height: 113.h,
      decoration: BoxDecoration(
        color: const Color(0xff6C7A8F).withOpacity(0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "提款手续费",
                  style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 13.sp),
                ),
                Text(
                  "提款金额",
                  style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 13.sp),
                ),
                Text(
                  "预计到账时间",
                  style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 13.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "2%",
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
                Obx(
                  () => Text(
                    "${controller.withTotalAmount.value} ¥",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                ),
                Text(
                  "5分钟",
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarning() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(),
        children: [
          TextSpan(
            text: "*注意\n",
            style: TextStyle(
              color: Color(0xffFF8A00),
              height: 1.5,
            ),
          ),
          TextSpan(
            style: TextStyle(
              color: Color(0xffA6ACC0),
              height: 1.5,
            ),
            text: "参考汇率 1R\$=1¥汇率以实际付款时为准0R\$存入您的 私人账户。出于安全考虑，大额或可疑提款可能需要 1-6小时进行审核过程。感谢您的耐心等待！",
          ),
        ],
      ),
    ).marginSymmetric(vertical: 30.h);
  }
}
