import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/models/user_info_model.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/mine/mine_logic.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/utils/string_util.dart';
import 'package:kkguoji/widget/inkwell_view.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../widget/show_toast.dart';

GlobalKey _shareImageRepaintBoundaryKey = GlobalKey();

class MinePage extends GetView<MineLogic> {
  MinePage({super.key});

  final userController = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<MineLogic>(
      init: MineLogic(),
      id: "MinePage",
      builder: (MineLogic controller) {
        return Scaffold(
          body: SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                _buildTop(),
                Positioned(
                  top: 165.h,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      Expanded(flex: 1, child: _buildItems()),
                      _buildLogOutBtn(context).marginOnly(top: 30.h, bottom: 20.h),
                    ],
                  ),
                ),
                // _buildMyWallet(),
                if (controller.isSharePopViewVisible) ..._sharePopView()
              ],
            ),
          ),
        );
      },
    );
  }

  ///头部背景
  Widget _buildTop() {
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Assets.imagesIconTopBg),
        ),
      ),
      child: Stack(
        children: [
          _buildRightSetting(),
          _buildUserInfo(),
        ],
      ),
    );
  }

  ///功能设置
  Widget _buildRightSetting() {
    return Positioned(
      top: 44.h,
      right: 13.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              //进入消息界面
              onPressed: () => RouteUtil.pushToView(Routes.messagePage),
              icon: Image.asset(
                Assets.imagesIconInform,
                width: 30,
                height: 30,
              )),
          IconButton(
              //设置
              onPressed: () {
                //进入安全设置界面
                RouteUtil.pushToView(Routes.settingPage);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SetinagePage()));
              },
              icon: Image.asset(
                Assets.imagesIconSetting,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }

  ///用户信息
  Widget _buildUserInfo() {
    return Positioned(
      top: 91.h,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => AvatarWithVip(
                urlPath: userController.userInfoModel.value?.portrait,
              ),
            ),
            const SizedBox(
              width: 10,
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Text(
                    //昵称
                    '${userController.userInfoModel.value?.userNick}',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  );
                }),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Image.asset(
                      Assets.imagesIconId,
                      width: 10,
                      height: 10,
                    ),
                    const SizedBox(width: 3),
                    InkWellView(
                        child: Row(
                          children: [
                            Obx(() {
                              return Text(
                                '${userController.userInfoModel.value?.uuid}',
                                style: TextStyle(fontSize: 12.sp, color: Colors.white),
                              );
                            }),
                            SizedBox(width: 5.w),
                            Image.asset(Assets.promotionCopy, width: 12.w, height: 12.h),
                          ],
                        ),
                        onPressed: () =>
                            StringUtil.clipText('${userController.userInfoModel.value?.uuid}')),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 22),
            GestureDetector(
                child: //编辑
                    Container(
                  width: 67,
                  height: 25,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage(Assets.imagesIconEditBg))),
                  child: const Center(
                    //文字居中
                    child: Text(
                      '编辑',
                      style:
                          TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () async {
                  final data = await Get.toNamed(
                    Routes.personalInfoPage,
                    arguments: {
                      "nick": userController.userInfoModel.value?.userNick,
                      "urlPath": userController.userInfoModel.value?.portrait,
                    },
                  );
                  userController.userInfoModel.value = data;
                  controller.portraitUrl.value = (data as UserInfoModel).portrait ?? "";
                }),
          ],
        ),
      ),
    );
  }

  ///功能清单
  Widget _buildItems() {
    return SingleChildScrollView(
      child: Column(
        children: [
          MyPurse().paddingSymmetric(horizontal: 12.w),
          SizedBox(height: 20.h),
          //功能未开放
          // const SafeBoxWaitGridView(),
          MyAccountInfo(controller: controller),
          Container(
            height: 8.h,
            color: Colors.black,
          ),
          WelfareReward(shareOnTap: () {
            controller.setIsSharePopViewVisible(true);
          }),
        ],
      ),
    );
  }

  ///退出按钮
  Widget _buildLogOutBtn(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      height: 40,
      decoration: ShapeDecoration(
          color: const Color(0xFF686F83),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesIconLogOut, width: 18, height: 18),
            const Text(
              '退出登录',
              style: TextStyle(color: Colors.white, fontSize: 13),
            )
          ],
        ),
        onPressed: () {
          _showDialog(context);
        },
      ),
    );
  }

  ///退出弹框
  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 2 / 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      Assets.imagesIconShowDiaBg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                    top: 30,
                    left: 35,
                    right: 35,
                    child: Center(
                      child: Text(
                        '确定要退出吗?',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 102,
                        height: 40,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 2, color: Color(0xFF3D35C6)),
                          borderRadius: BorderRadius.circular(20),
                        )),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              controller.userService.logout();
                            },
                            child: const Text(
                              '确定',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                            )),
                      ),
                      Container(
                        width: 102,
                        height: 40,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 2, color: Color(0xFF3D35C6)),
                          borderRadius: BorderRadius.circular(20),
                        )),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              '取消',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  List<Widget> _sharePopView() {
    var url = controller.promotionModel?.image?.first ??
        'https://kk-hongkong-hall.s3.ap-east-1.amazonaws.com/temps/images/2024/01/05/zvRTsdfZd397sCQZ.jpg';
    return [
      Positioned.fill(
        child: GestureDetector(
          onTap: () {
            controller.setIsSharePopViewVisible(false);
          },
          child: Container(
            color: Colors.black54,
          ),
        ),
      ),
      Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.w),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2E374C),
                        Color(0xFF181E2F),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: RepaintBoundary(
                    key: _shareImageRepaintBoundaryKey,
                    child: Stack(
                      children: [
                        Image.network(
                          url, // Replace with your image URL
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          bottom: 34.w,
                          right: 18.w,
                          child: QrImageView(
                            padding: EdgeInsets.all(8.w),
                            backgroundColor: Colors.white,
                            data: controller.promotionModel?.domain?.first?.url ?? "",
                            version: QrVersions.auto,
                            size: 48.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 26.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40.w,
                      decoration: BoxDecoration(
                        // color: const Color.fromRGBO(10, 11, 34, 0.12),
                        gradient:
                            const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]),
                        borderRadius: BorderRadius.circular(22.w),
                      ),
                      child: TextButton(
                          onPressed: () async {
                            await captureAndSaveImage();
                          },
                          child: const Text(
                            '保存海报',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                    ).expanded(),
                    SizedBox(
                      width: 18.w,
                    ),
                    Container(
                      height: 40.w,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0xFF3D35C6)),
                        borderRadius: BorderRadius.circular(22.w),
                      )),
                      child: TextButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: '123'));
                            StringUtil.clipText(
                                controller.promotionModel?.domain?.first?.url ?? "");
                          },
                          child: const Text(
                            '复制链接',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                    ).expanded(),
                  ],
                ),
              ],
            ),
          )),
    ];
  }

  Future<void> captureAndSaveImage() async {
    RenderRepaintBoundary boundary =
        _shareImageRepaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    saveImage(pngBytes);
  }

  Future<void> saveImage(Uint8List pngBytes) async {
    final result = await ImageGallerySaver.saveImage(pngBytes);
    if (result["isSuccess"] == true) {
      ShowToast.showToast("保存成功");
    } else {
      ShowToast.showToast("保存失败，没有访问权限");
    }
  }
}

class AvatarWithVip extends StatelessWidget {
  final String? urlPath;

  const AvatarWithVip({super.key, this.urlPath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          // 头像
          width: 50,
          height: 50,
          decoration: null == urlPath
              ? const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesIconHeaderDefault),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(urlPath!),
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Positioned(
          bottom: -7, // 负数表示往上移动
          child: // VIP 标识
          Image.asset(
            "assets/images/vip/VIP${UserService.to.userInfoModel.value?.level ?? 0}.png",
            width: 40,
            height: 25,
          )
          //     Container(
          //   width: 35,
          //   height: 14,
          //   // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          //   decoration: BoxDecoration(
          //     color: const Color(0xff687083),
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min, //尺寸以适应内容
          //     mainAxisAlignment: MainAxisAlignment.center, //水平方向上居中对齐
          //     crossAxisAlignment: CrossAxisAlignment.center, //垂直方向上居中对齐
          //     children: [
          //       Image.asset(
          //         "assets/images/vip/VIP${UserService.to.userInfoModel.value?.level ?? 0}.png",
          //         width: 15,
          //         height: 15,
          //       ),
          //       const SizedBox(width: 3),
          //       const Text(
          //         '0',
          //         style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
          //       )
          //     ],
          //   ),
          // ),
        )
      ],
    );
  }
}

//我的钱包
class MyPurse extends GetView<MineLogic> {
  MyPurse({super.key});

  final userService = Get.find<UserService>();

  // final controller = Get.find<MineLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineLogic>(
        id: "balance",
        builder: (logic) {
          return Container(
            height: 175,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(Assets.imagesIconMypurseBg), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(6),
              // border: Border.all(width: 1.0, color: Colors.white),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '我的钱包',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      GestureDetector(
                        child: Row(
                          children: [
                            const Text(
                              '进入钱包',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            Image.asset(
                              Assets.imagesIconArrowsEnter,
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ),
                        onTap: () {
                          RouteUtil.pushToView(Routes.walletPage);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  child: Image.asset(Assets.imagesIconDottedLine, height: 1.5),
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '钱包余额',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        controller.isHiddenBalance
                            ? "****"
                            : StringUtil.formatAmount("${userService.userMoneyModel?.money}"),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.toggleHiddenBalance();
                          },
                          icon: Image.asset(
                            controller.isHiddenBalance
                                ? Assets.imagesIconEyeClose
                                : Assets.imagesIconEyeOpen,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                ),
                /*Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      controller.isHiddenBalance ? "****" : StringUtil.formatAmount(
                          "${userService.userMoneyModel?.money}"),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        onPressed: () {
                          controller.toggleHiddenBalance();
                        },
                        icon: Image.asset(
                          controller.isHiddenBalance
                              ? Assets.imagesIconEyeClose
                              : Assets.imagesIconEyeOpen,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ))
                  ],
                ),
              );
            }),*/
                const TopUpWithdrawBackwater(),
              ],
            ),
          );
        });
  }
}

//充值、提现、返水
class TopUpWithdrawBackwater extends StatelessWidget {
  const TopUpWithdrawBackwater({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWellView(
          height: 40.h,
          width: 100.w,
          backColor: const Color(0xFF2D374E),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.imagesIconTopUp, width: 25, height: 25),
              const SizedBox(width: 5),
              const Text(
                '充值',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          onPressed: () => RouteUtil.pushToView(Routes.recharge, arguments: true),
        ),
        InkWellView(
          height: 40.h,
          width: 100.w,
          backColor: const Color(0xFF2D374E),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.imagesIconWithdraw, width: 25, height: 25),
              const SizedBox(width: 5),
              const Text(
                '提现',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          onPressed: () => RouteUtil.pushToView(Routes.withdraw, arguments: true),
        ),
        InkWellView(
          height: 40.h,
          width: 100.w,
          backColor: const Color(0xFF2D374E),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.imagesIconFanshui, width: 25, height: 25),
              const SizedBox(width: 5),
              const Text(
                '返水',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          onPressed: () {
            // print("返水");
            RouteUtil.pushToView(Routes.rebate);
          },
        ),
      ],
    );
  }
}

//保险箱、VIP、返水、推广赚钱
class SafeBoxWaitGridView extends StatelessWidget {
  const SafeBoxWaitGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 12, right: 12),
          height: 93,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesIconSafeboxBg), fit: BoxFit.cover)),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            //禁止滚动
            crossAxisCount: 4,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              // 保险箱
              InkWellView(
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imagesIconSafeBox,
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '保险箱',
                      style:
                          TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              // VIP
              InkWellView(
                onPressed: () {},
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imagesIconVipImage,
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      'VIP',
                      style:
                          TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              // 返水
              InkWellView(
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imagesIconBackWater,
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '返水',
                      style:
                          TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              // 推广赚钱
              InkWellView(
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imagesIconPaidPromote,
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '推广赚钱',
                      style:
                          TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//账户、个人数据、游戏记录
class MyAccountInfo extends StatelessWidget {
  final MineLogic controller;

  MyAccountInfo({super.key, required this.controller});

  final userController = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              Assets.imagesIconAccount,
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '账号',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              Assets.imagesIconArrowsEnter,
              width: 16,
              height: 16,
            ),
            onTap: () {
              RouteUtil.pushToView(Routes.myAccountPage,
                  arguments: {"urlPath": userController.userInfoModel.value?.portrait});
            },
          ),
          const Divider(
            color: Color.fromRGBO(255, 255, 255, 0.06),
            height: 1,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: Image.asset(
              Assets.imagesIconPersonal,
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '个人数据',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              Assets.imagesIconArrowsEnter,
              width: 16,
              height: 16,
            ),
            onTap: () {
              RouteUtil.pushToView(Routes.personalData);
            },
          ),
          const Divider(
            color: Color.fromRGBO(255, 255, 255, 0.06),
            height: 1,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: Image.asset(
              Assets.imagesIconGameRecord,
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '游戏记录',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              Assets.imagesIconArrowsEnter,
              width: 16,
              height: 16,
            ),
            onTap: () {
              RouteUtil.pushToView(Routes.betListPage);
            },
          ),
        ],
      ),
    );
  }
}

//福利奖励、信息设置、分享
class WelfareReward extends StatelessWidget {
  void Function() shareOnTap;

  WelfareReward({super.key, required this.shareOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          // ListTile(
          //   leading: Image.asset(
          //     Assets.imagesIconAward,
          //     width: 18,
          //     height: 18.5,
          //     fit: BoxFit.cover,
          //   ),
          //   title: const Text(
          //     '福利奖励',
          //     style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
          //   ),
          //   trailing: Image.asset(
          //     Assets.imagesIconArrowsEnter,
          //     width: 16,
          //     height: 16,
          //   ),
          //   onTap: () {
          //     print('福利奖励');
          //   },
          // ),
          const Divider(
            color: Color.fromRGBO(255, 255, 255, 0.06),
            height: 1,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: Image.asset(
              Assets.imagesIconMessaageSet,
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '信息设置',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              Assets.imagesIconArrowsEnter,
              width: 16,
              height: 16,
            ),
            onTap: () => RouteUtil.pushToView(Routes.informationSettingsPage),
          ),
          const Divider(
            color: Color.fromRGBO(255, 255, 255, 0.06),
            height: 1,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: Image.asset(
              Assets.imagesIconMineShare,
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '分享',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              Assets.imagesIconArrowsEnter,
              width: 16,
              height: 16,
            ),
            onTap: () {
              shareOnTap.call();
            },
          ),
        ],
      ),
    );
  }
}
