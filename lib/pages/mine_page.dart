import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/setting/setting.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return   const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 350,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  MyHeader(),
                  Positioned(
                    top: 160,
                    left: 10,
                    right: 10,
                    child: Mypurse(),
                  )
                ],
              ),
            ),
            Column(
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
      ),
    );
  }
}

class MyHeader extends StatelessWidget {
  const MyHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    //信息
                      onPressed: () {
                        //进入消息界面
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
              SizedBox(height: 10,),
              Container(padding: const EdgeInsets.only(left: 20), child: Row(
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
                      const Text(
                        'gogo',
                        style: TextStyle(
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
                          const Text(
                            '123456',
                            style: TextStyle(
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
                              image:
                              AssetImage('assets/images/icon_edit_bg.png'))),
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
              ),)
            ],
          ),
        ),
        // Positioned(
        //     //设置、消息
        //     top: 40,
        //     right: 12,
        //     child: ),
        // Positioned(
        //     //头像
        //     left: 16,
        //     bottom: 50,
        //     child: ),
      ],
    );
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
              image: AssetImage('assets/images/icon_header_default.png'),
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
                  'assets/images/icon_vip.png',
                  width: 15,
                  height: 15,
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  '0',
                  style: TextStyle(
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
}

//我的钱包
class Mypurse extends StatelessWidget {
  const Mypurse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 167,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/icon_mypurse_bg.png'),
              fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1.0, color: Colors.white)
      ),
      child: Column(
        children: [
          const SizedBox(height: 10,),
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
                const Text(
                  '¥88,686.00',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/icon_eye_close.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
          const SizedBox(height: 0),
          TopUpWithdrawBackwater(),
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
    return  Row(
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
              const SizedBox(width: 5,),
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
                'assets/images/icon_top_up.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 5,),
              const Text(
                '体现',
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
                'assets/images/icon_top_up.png',
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 5,),
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
          print('退出登录');
        },
      ),
    );
  }
}
