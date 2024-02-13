import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/services/user_service.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../../../common/models/user_info_model.dart';
import '../../../generated/assets.dart';
import 'logic.dart';

class InformationSettingsPage extends StatefulWidget {
  const InformationSettingsPage({Key? key}) : super(key: key);

  @override
  State<InformationSettingsPage> createState() => _InformationSettingsPageState();
}

class _InformationSettingsPageState extends State<InformationSettingsPage> {
  final logic = Get.put(InformationSettingsLogic());
  final state = Get.find<InformationSettingsLogic>().state;
  late MyListView _myListView;

  @override

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
  Widget _buildView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('信息设置'),
        centerTitle: true,
        leading:  IconButton(
          icon: Image.asset(
              Assets.systemIconBack,
              width: 20.w,
              height: 20.w),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Obx((){
                UserInfoModel? userInfoModel = UserService.to.userInfoModel.value;
                _myListView = MyListView(userInfoModel: userInfoModel,);
                return _myListView;
              }),
            ),
            _buildLogOutBtn(btnOntap),
            SizedBox(height: 20.w)
          ],
        ),
      ),
    );
  }

  btnOntap() async {
    if(logic.isChanged == false) return;
    var contacts = _myListView.getContacts();
    bool result = await logic.updateContact(contacts[0], contacts[1],contacts[2],contacts[3],contacts[4]);
    if (result) {
      ShowToast.showToast("更新成功");
    }
  }

  Widget _buildLogOutBtn(void Function() onTap) {
    return GetBuilder<InformationSettingsLogic>(
      id: 'updateBtn',
      builder: (_) {
        return Opacity(
          opacity: logic.isChanged ? 1 : 0.5,
          child: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            height: 40,
            decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3D35C6), // 起始颜色
                    Color(0xFF6C4FE0), // 结束颜色
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            child: TextButton(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '保存',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  )
                ],
              ),
              onPressed: () {
                onTap.call();
              },
            ),
          ),
        );
      },
    );
  }
}


class MyListView extends StatelessWidget {

  UserInfoModel? userInfoModel;
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  TextEditingController _textEditingController3 = TextEditingController();
  TextEditingController _textEditingController4 = TextEditingController();
  TextEditingController _textEditingController5 = TextEditingController();

  List<String> getContacts() {
    return [_textEditingController1.text,
      _textEditingController2.text,
      _textEditingController3.text,
      _textEditingController4.text,
      _textEditingController5.text,];
}
  MyListView({required this.userInfoModel});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MyListItem(imageN: Assets.mineInformationSettingsWechat,title: '微信', defaultText: '您的微信账号', textEditingController: _textEditingController1, text: userInfoModel?.weixin,),
          MyListItem(imageN: Assets.mineInformationSettingsQQ,title: 'QQ', defaultText: '您的QQ账号', textEditingController: _textEditingController2, text:  userInfoModel?.qq),
          MyListItem(imageN: Assets.serviceServiceTelegrame,title: 'Telegram', defaultText: '您的Telegram账号', textEditingController: _textEditingController3, text:  userInfoModel?.telegram),
          MyListItem(imageN: Assets.mineInformationSettingsSkype,title: 'Skype', defaultText: '您的Skype账号', textEditingController: _textEditingController4, text:  userInfoModel?.skype),
          MyListItem(imageN: Assets.mineInformationSettingsWhatsapp,title: 'Whatsapp', defaultText: '您的WhatApp账号', textEditingController: _textEditingController5, text:  userInfoModel?.whatsapp),
        ],
      ),
    );
  }
}

class MyListItem extends StatelessWidget {

  final logic = Get.put(InformationSettingsLogic());
  late String imageN;
  late String title;
  late String defaultText;
  late String? text;
  late TextEditingController textEditingController;
  MyListItem({required this.imageN,required this.title,required this.defaultText, required this.textEditingController, required this.text});

  @override
  Widget build(BuildContext context) {
    textEditingController.text = text ?? "";
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(imageN, width: 22.w, height: 22.w,),
              SizedBox(width: 10.w),
              Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 14.sp),)
            ],
          ),
          SizedBox(height: 8.0),
          SizedBox(
            height: 42.w,
            child: TextField(
              controller: textEditingController,
              onChanged: (value) {
                logic.setIsChanged(true);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 32.w),
                hintText: defaultText,
                hintStyle: TextStyle(color: Color(0xFFFFFFFF).withOpacity(0.2), fontSize: 15.sp, fontWeight: FontWeight.w400),
                filled: true,
                fillColor: Color(0x3D6C7A8F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(34.w),
                  borderSide: BorderSide.none, // 可以选择去掉边框
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}