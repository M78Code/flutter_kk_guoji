import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';
import 'package:kkguoji/pages/recharge/widgets/ex_widgets.dart';
import 'package:kkguoji/pages/withdraw/withdraw_logic.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/widget/keyboard_dismissable.dart';

class WithdrawPage extends GetView<WithdrawLogic> {
  const WithdrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<WithdrawLogic>(
        init: WithdrawLogic(),
        id: "WithdrawPage",
        builder: (_) {
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
              ),
              body: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 17.h),
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
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 13.h),
                    _buildCoinCategory(),
                    // _buildCoinType(),
                    SizedBox(height: 18.h),
                    _buildUsableMoney(),
                    SizedBox(height: 32.h),
                    Text(
                      "选择类型",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 13.h),
                    _buildSelectCategory(),
                    SizedBox(height: 25.h),
                    _buildInputName(),
                    SizedBox(height: 25.h),
                    _buildInputAccount(),
                    SizedBox(height: 25.h),
                    _buildInputAmount(),
                    SizedBox(height: 30.h),
                    _buildTip(),
                    _buildWithdrawInfo(),
                    buttonSubmit(
                      text: "确认提现",
                      height: 55,
                      onPressed: () => controller.withdrawSubmit(),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///选择类型Spinner
  Widget _buildSelectCategory() {
    return Obx(
      () {
        List<CategoryModel> selectOptions = controller.typeOptions[controller.coinCategoryIndex]!;
        return Wrap(
          spacing: 20.w,
          runSpacing: 15.h,
          children: List.generate(
            selectOptions.length,
            (index) => CategoryRadioWidget(
              category: selectOptions[index],
              isSelected: controller.selectTypeIndex.value == selectOptions[index].index,
              onTap: (category) {
                controller.onSelectCategoryUpdate(category.index);
                print("选择类型的值:${category.name}");
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
            isSelected: controller.coinCategoryIndex.value == controller.options[index].index,
            onTap: (category) {
              controller.onCoinCategoryUpdate(category.index);
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
            "100.00 ¥",
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
          hintText: "请输入收款人姓名",
          hintTextSize: 15,
          editController: controller.nameController,
        ),
      ],
    );
  }

  ///收款账户
  Widget _buildInputAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "收款账户",
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 14.h),
        inputTextEdit(
          hintText: "请输入银行卡卡号",
          hintTextSize: 15,
          editController: controller.accountController,
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

  ///提示
  Widget _buildTip() {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(Assets.rechargeIconTip, width: 14.w, height: 14.h),
            SizedBox(width: 5.w),
            Text(
              "最低充值金额不低于5.0 ¥",
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
              "最高充值金额不低于80000.0 ¥",
              style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 12.sp),
            ),
          ],
        )
      ],
    );
  }

  ///提现信息
  Widget _buildWithdrawInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.w),
      margin: EdgeInsets.only(top: 45.h, bottom: 29.h),
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
                  "提款金额",
                  style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 13.sp),
                ),
                Text(
                  "提款手续费",
                  style: TextStyle(color: const Color(0xffA6ACC0), fontSize: 13.sp),
                ),
                Text(
                  "提款总额",
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
                Obx(
                  () => Text(
                    "${controller.withdrawAmount.value} ¥",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
