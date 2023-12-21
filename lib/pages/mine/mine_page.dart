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

import '../../services/sqlite_service.dart';
import 'package:kkguoji/services/cache_key.dart';

class MinePage extends GetView<MineLogic> {
  const MinePage({super.key});

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
                      MyPurse().paddingSymmetric(horizontal: 12.w),
                      Expanded(flex: 1, child: _buildItems()),
                      _buildLogOutBtn(context).marginOnly(top: 32.h, bottom: 36.h),
                    ],
                  ),
                ),
                // _buildMyWallet(),
              ],
            ),
          ),
        );
      },
    );
  }

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

  Widget _buildRightSetting() {
    return Positioned(
      top: 44.h,
      right: 13.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              //信息
              onPressed: () {
                //进入消息界面
                RouteUtil.pushToView(Routes.messageCenter);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const MessageCenterPage()));
              },
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

  Widget _buildUserInfo() {
    return Positioned(
      top: 91.h,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const AvatarWithVip(),
            const SizedBox(
              width: 10,
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //昵称
                  '${controller.userInfoModel?.userNick}',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
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
                            Text(
                              '${controller.userInfoModel?.uuid}',
                              style: TextStyle(fontSize: 12.sp, color: Colors.white),
                            ),
                            SizedBox(width: 5.w),
                            Image.asset(Assets.promotionCopy, width: 12.w, height: 12.h),
                          ],
                        ),
                        onPressed: () => StringUtil.clipText('${controller.userInfoModel?.uuid}')),
                  ],
                )
              ],
            ),
            const SizedBox(width: 22),
            GestureDetector(
              child: //编辑
                  Container(
                width: 67,
                height: 25,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesIconEditBg))),
                child: const Center(
                  //文字居中
                  child: Text(
                    '编辑',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onTap: () => RouteUtil.pushToView(Routes.personalInfoPage),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItems() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          const SafeBoxWaitGridView(),
          const MyAccountInfo(),
          Container(
            height: 8.h,
            color: Colors.black,
          ),
          const WelfareReward(),
        ],
      ),
    );
    return ListView(
      children: [
        //先不开发
        const SafeBoxWaitGridView(),
        const MyAccountInfo(),
        Divider(height: 8.h, color: Colors.black),
        const WelfareReward(),
      ],
    );
  }

  Widget _buildLogOutBtn(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      height: 40,
      decoration: ShapeDecoration(color: const Color(0xFF686F83), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
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

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  Assets.imagesIconShowDiaBg,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                    top: 60,
                    left: 35,
                    right: 35,
                    child: Center(
                      child: Text(
                        '这将使您需要重新登录才能使用我们的服务！确定要退出吗?',
                        softWrap: true,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 23,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 102,
                        height: 40,
                        decoration: ShapeDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              controller.userService.logout();
                            },
                            child: const Text(
                              '确定',
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
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
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
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
}

class AvatarWithVip extends StatelessWidget {
  const AvatarWithVip({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          // 头像
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(Assets.imagesIconHeaderDefault),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0, // 负数表示往上移动
          child: // VIP 标识
              Container(
            width: 35,
            height: 14,
            // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
            decoration: BoxDecoration(
              color: const Color(0xff687083),
              borderRadius: BorderRadius.circular(4),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min, //尺寸以适应内容
              mainAxisAlignment: MainAxisAlignment.center, //水平方向上居中对齐
              crossAxisAlignment: CrossAxisAlignment.center, //垂直方向上居中对齐
              children: [
                Image.asset(
                  Assets.imagesIconVip,
                  width: 15,
                  height: 15,
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

//我的钱包
class MyPurse extends StatelessWidget {
  MyPurse({super.key});

  final userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage(Assets.imagesIconMypurseBg), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1.0, color: Colors.white),
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
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
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
            padding: EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '钱包余额',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "¥${userService.userMoneyModel?.money}",
                  style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      Assets.imagesIconEyeClose,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
          const TopUpWithdrawBackwater(),
        ],
      ),
    );
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
          onPressed: () {
            print("充值");
          },
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
          onPressed: () {
            print("提现");
          },
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
            print("返水");
          },
        ),
        /*GestureDetector(
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF2D374E),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.imagesIconWithdraw,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '返水',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          onTap: () {
            print('返水');
          },
        ),*/
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
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesIconSafeboxBg), fit: BoxFit.cover)),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            //禁止滚动
            crossAxisCount: 4,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              // 保险箱
              GestureDetector(
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imagesIconSafeBox,
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '保险箱',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onTap: () {
                  print('保险箱');
                },
              ),

              // VIP
              GestureDetector(
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imagesIconVipImage,
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      'VIP',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onTap: () {
                  print('VIP');
                },
              ),

              // 返水
              GestureDetector(
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imagesIconBackWater,
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '返水',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onTap: () {
                  print('返水');
                },
              ),
              // 推广赚钱
              GestureDetector(
                child: Column(
                  children: [
                    Image.asset(
                      Assets.imagesIconPaidPromote,
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '推广赚钱',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                onTap: () {
                  print('推广赚钱');
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

//账户、个人数据、游戏记录
class MyAccountInfo extends StatelessWidget {
  const MyAccountInfo({super.key});

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
              // print("kkk账号:${}");
              RouteUtil.pushToView(Routes.myAccountPage);
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
  const WelfareReward({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              Assets.imagesIconAward,
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '福利奖励',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              Assets.imagesIconArrowsEnter,
              width: 16,
              height: 16,
            ),
            onTap: () {
              print('福利奖励');
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
            onTap: () {
              print('信息设置');
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
              Assets.imagesIconLogOut,
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
              print('分享');
            },
          ),
        ],
      ),
    );
  }
}
