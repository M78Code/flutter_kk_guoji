import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/message/message.dart';
import 'package:kkguoji/pages/setting/setting.dart';
import 'package:kkguoji/pages/welfare_reward/welfare_reward_page.dart';
import 'package:kkguoji/utils/sqlite_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/models/user_info_model.dart';
import '../routes/routes.dart';
import '../services/cache_key.dart';
import '../services/config.dart';
import '../services/http_service.dart';
import '../utils/route_util.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  late final UserInfoModel _model;
  // ignore: prefer_typing_uninitialized_variables
  var _isEyeClose; //是否明文

  Future<void> fetchData() async {
    // 模拟异步加载数据
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      getUserInfo();
      getEyeClose();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  getUserInfo() async {
    var result = await HttpRequest.request(HttpConfig.getUserInfo);
    if (result["code"] == 200) {
      _model = UserInfoModel.fromJson(result["data"]);
    }

    return null;
  }

  // 读取bool值
  void getEyeClose() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isEyeClose = prefs.getBool('isEyeClose') ?? false; // 如果没有取到值，默认为false
  }

  // 存储bool值
  void saveEyeClose(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isEyeClose', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: fetchData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 350,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      _model == null ? Text('123') : _myHeaderView(),
                      Positioned(
                        top: 160,
                        left: 10,
                        right: 10,
                        child: _mypurseView(),
                      )
                    ],
                  ),
                ),
                const Column(
                  children: [
                    SafeBoxWaitGridView(), //保险箱等
                    SizedBox(height: 0),
                    MyAccountInfo(), //账号信息等
                    BlackInterval(), //黑色间隔线
                    WelfareReward(), //福利奖励等
                    SizedBox(height: 20),
                    logOutBtn(), //退出登录
                    SizedBox(height: 20),
                  ],
                )
              ],
            ),
          )),
    );
  }

//头像
  Widget _myHeaderView() {
    return Stack(
      children: [
        Container(
          //背景图
          height: 180,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/icon_top_bg.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      //信息
                      onPressed: () {
                        //进入消息界面
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MessageCenterPage()));
                      },
                      icon: Image.asset(
                        'assets/images/icon_inform.png',
                        width: 30,
                        height: 30,
                      )),
                  IconButton(
                      //设置
                      onPressed: () {
                        //进入安全设置界面
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SetinagePage()));
                      },
                      icon: Image.asset(
                        'assets/images/icon_setting.png',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    avatarWithVip(),
                    const SizedBox(
                      width: 10,
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //昵称
                          '${_model.userNick}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/icon_id.png',
                              width: 10,
                              height: 10,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${_model.uuid}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            )
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
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/icon_edit_bg.png'))),
                        child: const Center(
                          //文字居中
                          child: Text(
                            '编辑',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        //编辑
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget avatarWithVip() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          // 头像
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('${_model.portrait}'),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) {
                //网络图片为空就展示本土图片
                const AssetImage('assets/images/icon_header_default.png');
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0, // 负数表示往上移动
          child: // VIP 标识
              Container(
            width: 35,
            height: 14,
            decoration: BoxDecoration(
              color: _model.level == 0
                  ? const Color(0xff687083)
                  : const Color(0xffFF8A00),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, //尺寸以适应内容
              mainAxisAlignment: MainAxisAlignment.center, //水平方向上居中对齐
              crossAxisAlignment: CrossAxisAlignment.center, //垂直方向上居中对齐
              children: [
                Image.asset(
                  'assets/images/icon_vip.png',
                  width: 15,
                  height: 15,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '${_model.level}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

//我的钱包
  Widget _mypurseView() {
    return Container(
      height: 167,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/icon_mypurse_bg.png'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1.0, color: Colors.white)),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Image.asset(
                        'assets/images/icon_arrows_enter.png',
                        width: 16,
                        height: 16,
                      ),
                    ],
                  ),
                  onTap: () {
                    print('进入钱包');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Image.asset(
              'assets/images/icon_dotted_line.png',
              height: 1.5,
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '钱包余额',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
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
                  _isEyeClose == false ? '${_model.money}' : '****',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                IconButton(
                    //是否显示明文
                    onPressed: () {
                      setState(() {
                        _isEyeClose = !_isEyeClose;
                        saveEyeClose(_isEyeClose);
                      });
                    },
                    icon: _isEyeClose == false
                        ? Image.asset(
                            'assets/images/icon_eye_open.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/icon_eye_close.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ))
              ],
            ),
          ),
          const SizedBox(height: 0),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
                'assets/images/icon_top_up.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                '充值',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(width: 25),
        Container(
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
                'assets/images/icon_fanshui.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                '提现',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(width: 25),
        GestureDetector(
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
                  'assets/images/icon_withdraw.png',
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  '返水',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          onTap: () {
            print('返水');
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
                  image: AssetImage('assets/images/icon_safebox_bg.png'),
                  fit: BoxFit.cover)),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(), //禁止滚动
            crossAxisCount: 4,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              // 保险箱
              GestureDetector(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/icon_safe_box.png',
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '保险箱',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
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
                      'assets/images/icon_vip_image.png',
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      'VIP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
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
                      'assets/images/icon_back_water.png',
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '返水',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
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
                      'assets/images/icon_paid_promote.png',
                      width: 48,
                      height: 48,
                    ),
                    const Text(
                      '推广赚钱',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
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
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              'assets/images/icon_account.png',
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '账号',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              'assets/images/icon_arrows_enter.png',
              width: 16,
              height: 16,
            ),
            onTap: () {
              print('账户');
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
              'assets/images/icon_personal.png',
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '个人数据',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              'assets/images/icon_arrows_enter.png',
              width: 16,
              height: 16,
            ),
            onTap: () {
              print('个人数据');
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
              'assets/images/icon_game_record.png',
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '游戏记录',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              'assets/images/icon_arrows_enter.png',
              width: 16,
              height: 16,
            ),
            onTap: () {
              print('游戏记录');
            },
          ),
        ],
      ),
    );
  }
}

//黑色间隔
class BlackInterval extends StatelessWidget {
  const BlackInterval({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      color: Colors.black, // 黑色背景view
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
              'assets/images/icon_award.png',
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '福利奖励',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              'assets/images/icon_arrows_enter.png',
              width: 16,
              height: 16,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelfareRewardPage()));
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
              'assets/images/icon_messaage_set.png',
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '信息设置',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              'assets/images/icon_arrows_enter.png',
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
              'assets/images/icon_mine_share.png',
              width: 18,
              height: 18.5,
              fit: BoxFit.cover,
            ),
            title: const Text(
              '分享',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            trailing: Image.asset(
              'assets/images/icon_arrows_enter.png',
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

//退出登录
class logOutBtn extends StatelessWidget {
  const logOutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      height: 40,
      decoration: ShapeDecoration(
          color: const Color(0xFF686F83),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon_log_out.png',
                width: 18, height: 18),
            const Text(
              '退出登录',
              style: TextStyle(color: Colors.white, fontSize: 13),
            )
          ],
        ),
        onPressed: () {
          _showDialog(context);
          print('退出登录');
        },
      ),
    );
  }

//退出登录弹框
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
                  'assets/images/icon_showDia_bg.png',
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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
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
                            //渐变色
                            gradient: const LinearGradient(
                                colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: TextButton(
                            onPressed: () {
                              SqliteUtil()
                                  .remove(CacheKey.apiToken); //删除token等信息
                              Navigator.of(context).pop();
                              RouteUtil.pushToView(Routes.loginPage);
                            },
                            child: const Text(
                              '确定',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      Container(
                        width: 102,
                        height: 40,
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 2, color: Color(0xFF3D35C6)),
                          borderRadius: BorderRadius.circular(20),
                        )),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              '取消',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
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
