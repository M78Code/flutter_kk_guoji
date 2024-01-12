import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';
import 'package:kkguoji/pages/activity/list/widgets/item_widget.dart';
import 'package:kkguoji/pages/mine/message/message_card.dart';
import 'package:kkguoji/pages/mine/message/message_model.dart';
import 'package:kkguoji/pages/mine/message/message_request.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:kkguoji/pages/mine/message/message_service.dart';
import 'package:kkguoji/pages/mine/message/notice_card.dart';
import 'package:kkguoji/pages/mine/message/notice_model.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late EasyRefreshController _easyRefreshController;
  List<NoticeTypeModel> _noticeTypeList = [];
  List<MessageListModel> _messageList = [];
  var _type = 0; //选中类型
  late int page = 1;
  late int limit = 10;
  late bool hasMored;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
    //请求数据
    _getSelectBarData();
    _getMessageData(false);
  }

  //公告类型
  Future _getSelectBarData() async {
    var result = await MessageService.getNoticeSubType();
    if (result['code'] == 200) {
      List dataArray = result['data'];
      List<NoticeTypeModel> models = List<NoticeTypeModel>.from(
          dataArray.map((jsonMap) => NoticeTypeModel.fromMap(jsonMap)));
      setState(() {
        _noticeTypeList = models;
        NoticeTypeModel typeModel = NoticeTypeModel(id: 0, name: '全部公告');
        _noticeTypeList.insert(0, typeModel);
      });
    }
  }

  //公告列表
  Future _getMessageData(bool push) async {
    var result = await MessageService.getMessages(_type, page);
    if (result['code'] == 200) {
      List dataArray = result['data']["list"];
      List<MessageListModel> models = List<MessageListModel>.from(
          dataArray.map((jsonMap) => MessageListModel.fromMap(jsonMap)));

      //今后只要为私有数据赋值，都需要把赋值操作，放到setState当中才会刷新
      setState(() {
        hasMored = (page * limit) < result['data']["totalCount"];
        page++;
        if (push) {
          _messageList.addAll(models);
        } else {
          _messageList = models;
        }
      });
    } else {
      setState(() {
        //错误提示result['message']
      });
    }
  }

//下拉刷新
  Future _onRefresh() async {
    page = 1;
    await _getMessageData(false);
    //重置加载状态，使其再次使用
    _easyRefreshController.finishRefresh(); //下拉刷新完成
    _easyRefreshController.resetLoadState();
  }

  //上拉加载
  Future _onLoad() async {
    if (hasMored) {
      await _getMessageData(true);
    }
    //完成加载
    _easyRefreshController.finishLoad(noMore: !hasMored);
  }

  @override
  Widget build(BuildContext context) {
    //获取top标题
    Get.put(MessageRequest());
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息中心'),
        centerTitle: true, //将标题居中展示
        leading: IconButton(
            padding: const EdgeInsets.all(16.0),
            iconSize: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/images/back_normal.png')),
      ),
      body: _buildView(),
    );
  }

  Column _buildView() {
    return Column(
      children: [
        _buildSelectionView(),
        const Divider(
          color: Color.fromRGBO(255, 255, 255, 0.06),
          height: 1,
          indent: 10,
          endIndent: 10,
        ),
        const SizedBox(height: 15),
        Expanded(child: _messageListView()),
      ],
    );
  }

  Widget _buildSelectionView() {
    return Container(
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _noticeTypeList.length,
          itemBuilder: (BuildContext context, int index) {
            NoticeTypeModel typeModel = _noticeTypeList[index];
            return NoticeCard(
              model: typeModel,
              selectIndex: _type,
              onTap: (typeid) {
                _type = index;
                _onRefresh();
              },
            ).paddingOnly(right: 10);
          }),
    ).paddingSymmetric(horizontal: 12.w, vertical: 12.w);

    /*return GetBuilder<MessageRequest>(
      id: "categoryView",
      builder: (controller) {
        return Container(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.messageSelectBar.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                category: controller.selectBar[index],
                isSelected:
                    // ignore: unrelated_type_equality_checks
                    controller.selectedCategoryId ==
                        controller.selectBar[index].index,
                onTap: (selectIndex) {
                  controller.onCategoryTap(selectIndex);
                  setState(() {
                    _type = index + 1;
                    _onRefresh();
                  });
                },
              ).paddingOnly(right: 10);
            },
          ),
        ).paddingSymmetric(horizontal: 12.w, vertical: 12.w);
      },
    );*/
  }

  Widget _messageListView() {
    return EasyRefresh(
      header: ClassicalHeader(),
      footer: ClassicalFooter(),
      controller: _easyRefreshController,
      onRefresh: _onRefresh,
      onLoad: _onLoad,
      enableControlFinishRefresh: true,
      // enableControlFinishLoad: true,
      child: ListView.builder(
        itemCount: (_messageList.isEmpty) ? 1 : _messageList.length,
        itemBuilder: (BuildContext content, int index) {
          if (_messageList.isEmpty) {
            return Center(
              child: Image.asset(
                Assets.imagesIconEmptyh,
                fit: BoxFit.contain,
              ),
            );
          } else {
            MessageListModel model = _messageList[index];
            return Column(
              children: [
                MeeageCard(messageModel: model),
              ],
            );
          }
        },
      ),
    );
  }
}
