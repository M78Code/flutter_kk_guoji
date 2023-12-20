import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/recharge/recharge_logic.dart';
import 'package:kkguoji/pages/recharge/widgets/ex_widgets.dart';
import 'package:kkguoji/pages/recharge/widgets/recharge_radio.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/string_util.dart';
import 'package:kkguoji/widget/inkwell_view.dart';
import 'package:kkguoji/widget/keyboard_dismissable.dart';

class RechargePage extends GetView<RechargeLogic> {
  const RechargePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RechargeLogic(),
      id: "RechargePage",
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: Get.arguments != null
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset(
                    Assets.imagesBackNormal,
                    width: 20.w,
                    height: 20.h,
                  ),
                )
              : Container(),
          title: Text(
            "充值",
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
        body: _buildView(),
      ),
    );

    // Get.put(RechargeLogic());
    // return KeyboardDissmissable(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       leading: Get.arguments != null
    //           ? IconButton(
    //               onPressed: () => Navigator.pop(context),
    //               icon: Image.asset(
    //                 Assets.imagesBackNormal,
    //                 width: 20.w,
    //                 height: 20.h,
    //               ),
    //             )
    //           : Container(),
    //       title: Text(
    //         "充值",
    //         style: TextStyle(
    //             color: Colors.white,
    //             fontSize: 18.sp,
    //             fontWeight: FontWeight.w500),
    //       ),
    //       actions: [
    //         Padding(
    //           padding: EdgeInsets.only(right: 25.w),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             children: [
    //               Text(
    //                 "¥",
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 12.sp,
    //                   fontWeight: FontWeight.w700,
    //                 ),
    //               ),
    //               Text(
    //                 UserService.to.userMoneyModel?.money ?? "0.00",
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 16.sp,
    //                   fontWeight: FontWeight.w700,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //     body: Container(
    //       alignment: Alignment.centerLeft,
    //       padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 17.h),
    //       decoration: BoxDecoration(
    //           border: Border(
    //         top: BorderSide(
    //           width: 1.h,
    //           color: Colors.white.withOpacity(0.06),
    //         ),
    //       )),
    //       child: ListView(
    //         children: [
    //           Text(
    //             "充值货币",
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 14.sp,
    //                 fontWeight: FontWeight.w500),
    //           ),
    //           SizedBox(height: 13.h),
    //           Row(
    //             children: [
    //               RechargeRadio(
    //                 activePath: Assets.rechargeImgRechargeSelected,
    //                 defaultPath: Assets.rechargeImgRechargeDefault,
    //                 isSelected: true,
    //                 controller: controller.imageController,
    //                 onChange: (v) => print("ImageRadio_1--->$v"),
    //               ),
    //               const SizedBox(width: 18),
    //               RechargeRadio(
    //                 activePath: Assets.rechargeImgRechargeSelected,
    //                 defaultPath: Assets.rechargeImgRechargeDefault,
    //                 isSelected: false,
    //                 controller: controller.imageController,
    //                 onChange: (v) => print("ImageRadio_2--->$v"),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 35.h),
    //           Text(
    //             "充值金额",
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 14.sp,
    //                 fontWeight: FontWeight.w500),
    //           ),
    //           inputTextEdit(
    //             hintText: "请输入充值金额",
    //             editController: controller.rechargeController,
    //             keyboardType:
    //                 const TextInputType.numberWithOptions(decimal: true),
    //           ),
    //           SizedBox(height: 20.h),
    //           _buildRechargeCategoryView(),
    //           SizedBox(height: 40.h),
    //           Row(
    //             children: [
    //               Image.asset(Assets.rechargeIconTip, width: 14.w, height: 14.h),
    //               SizedBox(width: 5.w),
    //               const Text(
    //                 "最低充值金额不低于5.0 ¥",
    //                 style: TextStyle(color: Color(0xffA6ACC0)),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 11.h),
    //           Row(
    //             children: [
    //               Image.asset(Assets.rechargeIconTip, width: 14.w, height: 14.h),
    //               SizedBox(width: 5.w),
    //               const Text(
    //                 "最高充值金额不低于80000.0 ¥",
    //                 style: TextStyle(color: Color(0xffA6ACC0)),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 55.h),
    //           buttonSubmit(
    //             text: "立即充值",
    //             height: 55,
    //             onPressed: () {
    //               controller.recharge();
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildView() {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 17.h),
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          width: 1.h,
          color: Colors.white.withOpacity(0.06),
        ),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "账务账号:",
            style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
          _buildClip(),
          _buildRechargeTip(),
        ],
      ),
    );
  }

  Widget _buildClip() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 18.w),
          decoration: BoxDecoration(
            color: const Color(0xff5D42CE).withOpacity(0.5),
            border: Border.all(color: const Color(0xFF4E5AC5)),
            borderRadius: BorderRadius.circular(8.r),
          ),
          height: 43.h,
          width: 230.w,
          child: Text(
            "@dj-hfdsjfg",
            style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
        ),
        Positioned(
          right: 0,
          child: InkWellView(
            width: 90.w,
            height: 46.h,
            borderWidth: 0.5,
            borderColor: const Color(0xFF4E5AC5),
            gradient: const LinearGradient(
              colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
            ),
            onPressed: () => StringUtil.clipText("@dj-hfdsjfg"),
            child: Text(
              "复制",
              style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    ).marginOnly(top: 20.h, bottom: 43.h);
  }

  Widget _buildRechargeTip() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // textDirection: ,
          children: [
            Image.asset(
              Assets.rechargeIconTip,
              width: 14.w,
              height: 14.h,
              color: const Color(0xffFF8A00),
            ),
            SizedBox(width: 6.w),
            const Expanded(
              child: Text(
                "请复制 “财务账号”，并通过 Telegram 添加后进行充值。",
                style: TextStyle(
                  color: Colors.white,
                  height: 1.2
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // textDirection: ,
          children: [
            Image.asset(
              Assets.rechargeIconTip,
              width: 14.w,
              height: 14.h,
              color: const Color(0xffF32A2A),
            ),
            SizedBox(width: 6.w),
            const Expanded(
              child: Text(
                "更换财务Telegram账号前，我们将提前通过強窗公告公示三天，请留意公告，井认准官方唯一财务账号，達防上当受骗！",
                style: TextStyle(
                  color: Colors.white,
                    height: 1.2
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

/*Widget _buildRechargeCategoryView() {
    return GetBuilder<RechargeLogic>(
      id: "_buildRechargeCategoryView",
      builder: (RechargeLogic controller) {
        return Wrap(
          spacing: 20.w,
          runSpacing: 15.h,
          children: List.generate(
            controller.options.length,
            (index) => CategoryRadioWidget(
              category: controller.options[index],
              isSelected: controller.selectedValue.value ==
                  controller.options[index].index,
              onTap: (category) {
                controller.rechargeController.text = category.name.replaceAll(" ¥", ""); //更新输入框值
                print("充值中选择的值:${category.name}");
                controller.onCategoryTap(category.index);
              },
            ),
          ),
        );
      },
    );
  }*/
}
