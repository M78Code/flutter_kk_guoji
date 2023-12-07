// ignore_for_file: avoid_unnecessary_containers, unused_import, unused_label

import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/utils/app_util.dart';
import 'package:package_info/package_info.dart'; // 用于获取应用版本信息的包
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; //清除缓存

class SetinagePage extends StatefulWidget {
  const SetinagePage({super.key});

  @override
  State<SetinagePage> createState() => _SetinagePageState();
}

class _SetinagePageState extends State<SetinagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '安全设置',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        //在AppBar下方添加一条白色线
                        color: Color.fromRGBO(255, 255, 255, 0.06),
                        width: 1))),
          ),
          backgroundColor: const Color.fromRGBO(42, 43, 54, 1),
          leading: IconButton(
              padding: const EdgeInsets.all(16.0),
              iconSize: 20,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/images/back_normal.png')),
        ),
        body: MySeting());
  }
}

// ignore: must_be_immutable
class MySeting extends StatefulWidget {
  const MySeting({super.key});

  @override
  State<MySeting> createState() => _MySetingState();
}

class _MySetingState extends State<MySeting> {
  bool isSelected = false;

  //获取版本号
  String version = APPUtil().getAppVersion()!;

  //清除缓存
  void clearCache() async {
    DefaultCacheManager().emptyCache();
  }

  //通知开关
  void switchAntion() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(42, 43, 54, 1), // 背景颜色黑色
      child: Column(
        children: [
          const SizedBox(height: 42), // 顶部间距
          Column(
            children: [
              Image.asset(
                'assets/images/icon_seting_logo.png',
                width: 70,
                height: 70,
              ),
              const SizedBox(height: 20), // logo和版本号的间距
              Text(
                '版本号 $version',
                style: const TextStyle(
                    fontSize: 14, color: Color.fromRGBO(104, 112, 131, 1)),
              ), // 显示版本号
            ],
          ),
          const SizedBox(height: 60), // 版本号和消息通知的间距
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '消息通知',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {
                  switchAntion();
                },
                icon: isSelected
                    ? Image.asset('assets/images/icon_switch_close.png',
                        width: 54, height: 25)
                    : Image.asset(
                        'assets/images/icon_switch_open.png',
                        width: 54,
                        height: 25,
                      ),
              ),

              const SizedBox(width: 5), // 消息通知和右边的间距
            ],
          ),
          const SizedBox(height: 20), // 消息通知和黑色背景view的间距
          Container(
            height: 8,
            color: Colors.black, // 黑色背景view
          ),
          const SizedBox(height: 25), // 黑色背景view和语言设置的间距
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '语言设置',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // 语言设置和清除缓存的间距
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text('中文',
                      style: TextStyle(
                          color: Color.fromRGBO(104, 112, 131, 1),
                          fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'assets/images/icon_arrows_enter.png',
                    width: 16,
                    height: 16,
                  ),
                ),
              ],
            ),
            onTap: () {
              _showModalBottomSheet(context);
            },
          ),

          const SizedBox(height: 20), // 分割线
          const Divider(
            color: Color.fromRGBO(255, 255, 255, 0.06),
            height: 1,
            indent: 10,
            endIndent: 10,
          ),

          const SizedBox(height: 20), // 清除缓存和底部的间距
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '清除缓存',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          GestureDetector(
            //点击手势
            behavior: HitTestBehavior.translucent, //设置点击空白处也能响应
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '立即清除',
                    style: TextStyle(
                        color: Color.fromRGBO(104, 112, 131, 1), fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'assets/images/icon_arrows_enter.png',
                    width: 16,
                    height: 16,
                  ),
                ),
              ],
            ),
            onTap: () {
              _showDialog(context);
              print('立即清除');
            },
          ),

          const SizedBox(height: 20), // 分割线
          const Divider(
            color: Color.fromRGBO(255, 255, 255, 0.06),
            height: 1,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }

//弹框
  // ignore: unused_element
  void _showModalBottomSheet(BuildContext context) {
    // ignore: unused_local_variable
    int selectedIndex = 0; // 默认选中
    // ignore: unused_local_variable
    List itemList = [
      {'image': 'assets/images/icon_china.png', 'title': '中文'},
      {'image': 'assets/images/icon_english.png', 'title': 'English'},
      {'image': 'assets/images/icon_Japan.png', 'title': '日本語'},
      {'image': 'assets/images/iocn_brazil.png', 'title': 'brasileño'}
    ];

    showModalBottomSheet(
        backgroundColor: const Color.fromRGBO(45, 52, 74, 1),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 260,
            margin: const EdgeInsets.only(top: 25, bottom: 20),
            child: ListView.separated(
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.asset(
                    '${itemList[index]['image']}',
                    width: 23,
                    height: 23,
                  ),
                  title: Text('${itemList[index]['title']}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  trailing: selectedIndex == index
                      ? Image.asset(
                          'assets/images/icon_language_select.png',
                          width: 18,
                          height: 18,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      print(selectedIndex);
                    });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Color.fromRGBO(255, 255, 255, 0.06),
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                );
              },
            ),
          );
        });
  }

  //清除缓存弹框
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
                  child: Text(
                    '确定要清除缓存吗?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
                              clearCache();
                              Navigator.of(context).pop();
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

  //清除成功提示
  void showDeleteSuccess(BuildContext context) {
    const ScaffoldMessenger(
      // child: Container(
      //   width: 100,
      //   height: 40,
      //   clipBehavior: Clip.antiAlias,
      //   decoration: ShapeDecoration(
      //       gradient: const LinearGradient(
      //           colors: [Color(0xFF2E374C), Color(0xFF181E2F)]),
      //       shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(20))),
      // ),
      child: SnackBar(
        width: 100,
        backgroundColor: Colors.black,
        clipBehavior: Clip.antiAlias,
        content: Text(
          '清除成功',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }
}
