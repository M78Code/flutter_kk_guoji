import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/activity/list/widgets/item_widget.dart';
import 'package:kkguoji/pages/message/message_list.dart';
import 'package:kkguoji/pages/message/message_request.dart';
import 'package:kkguoji/routes/routes.dart';
import 'package:kkguoji/utils/route_util.dart';

class MessageCenterPage extends StatefulWidget {
  const MessageCenterPage({super.key});

  @override
  State<MessageCenterPage> createState() => _MessageCenterPageState();
}

class _MessageCenterPageState extends State<MessageCenterPage> {
  @override
  Widget build(BuildContext context) {
    //获取数据
    Get.put(MessageRequest());

    return Scaffold(
      appBar: AppBar(
        title: const Text('消息中心'),
        leading: IconButton(
            padding: const EdgeInsets.all(16.0),
            iconSize: 20,
            onPressed: () {
              print('返回');
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
    <<<<<<< HEAD
    // Expanded(child: _tabbleView()),
    =======
    MeeageListView(),
    >>>>>>> main
    ]
    ,
    );
  }

  Widget _buildSelectionView() {
    return GetBuilder<MessageRequest>(
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
// <<<<<<< HEAD
//                 isSelected: controller.selectedCategoryId ==
//                     controller.selectBar[index].index,
//                 onTap: (categoryId) {
//                   controller.onCategoryTap(categoryId);
// =======
                isSelected:
                // ignore: unrelated_type_equality_checks
                controller.type == controller.selectBar[index].index,
                onTap: (type) {
                  controller.onCategoryTap(type);
                  // type = index + 1;
                  initState();
                },
              ).paddingOnly(right: 10);
            },
          ),
        ).paddingSymmetric(horizontal: 12.w, vertical: 12.w);
      },
    );
  }
}

class MeeageListView extends StatefulWidget {
  const MeeageListView({super.key});

  @override
  State<MeeageListView> createState() => _MeeageListViewState();
}

class _MeeageListViewState extends State<MeeageListView> {
  // ignore: prefer_typing_uninitialized_variables,
  final ScrollController _scrollController = ScrollController();
  var messageList = [];
  var _page = 1; // 当前页数
  var type = 1; //选中类型
  var isShow = false; //是否展开所有内容

  @override
  //控件创建的时候，会执行
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
    getMessageListData();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getMessageListData(); // 滑动到底部时加载更多数据
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

//获取公告列表
  getMessageListData() async {
    // ignore: unused_local_variable
    var result = await HttpRequest.request(HttpConfig.getMessageList,
        method: "get", params: {"type": type, "page": _page, "limit": 10});

    if (result['code'] == 200) {
      //今后只要为私有数据赋值，都需要把赋值操作，放到setState当中才会刷新
      setState(() {
        messageList.addAll(result['data']["list"]);
        _page++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: messageList.length + 1, // 加上加载更多的item
        itemBuilder: (context, index) {
          if (index < messageList.length) {
            return Container(
              margin: const EdgeInsets.only(left: 0, right: 0, bottom: 15),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                  color: const Color(0xFF222633),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Positioned(
                          child: Text(
                            '${messageList[index]['create_time']}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Positioned(
                          child: Text(
                            '${messageList[index]['title']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 5),
                        Positioned(
                            child: Image.network(
                                '${messageList[index]['image']}')),
                        const SizedBox(height: 5),
                        Positioned(
                          child: HtmlWidget(
                            '${messageList[index]['content']}',
                            textStyle: TextStyle(
                                color:
                                isShow ? Color(0xFF686F83) : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Positioned(
                          child: GestureDetector(
                            child: Row(
                              children: [
                                const Expanded(child: Text('')), //用这个设置在右边
                                Text(
                                  isShow ? '显示所有' : '收起',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(width: 5),
                                isShow
                                    ? Image.asset(
                                  'assets/images/icon_down.png',
                                  width: 12,
                                  height: 12,
                                )
                                    : Image.asset(
                                  'assets/images/icon_up.png',
                                  width: 12,
                                  height: 12,
                                ),
                                //icon_up
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                isShow = !isShow;
                              });
                              print('显示所有');
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Positioned(
                          child: Divider(
                            color: Color.fromRGBO(255, 255, 255, 0.06),
                            height: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Positioned(
                          child: GestureDetector(
                            child: Row(
                              children: [
                                Text(
                                  '${messageList[index]['link_title']}',
                                  style: const TextStyle(
                                      color: Color(0xFF5D5FEF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const Expanded(child: Text('')), //用这个设置左右一个
                                Image.asset(
                                  'assets/images/icon_arrows_blue.png',
                                  width: 18,
                                  height: 18,
                                )
                              ],
                            ),
                            onTap: () {
                              RouteUtil.pushToView(Routes.webView,
                                  arguments:
                                  '${messageList[index]['link_title']}');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(), // 加载更多的指示器
            );
          }
        },
        // controller: _scrollController
      ),
    );
  }
}
