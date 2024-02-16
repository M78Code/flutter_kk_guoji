import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/widget/ScrollPageView/custom_srcoll_page_controller.dart';

import '../../model/home/jcp_game_model.dart';
import '../../pages/home/logic/logic.dart';
import '../../pages/home/view/home_ticket_item.dart';


///自定义Indicator
typedef IndicatorWidgetBuilder = Widget? Function(
    BuildContext context,
    int index,
    int length,
    );

///create by xt.sun
///2020/11/26
///可以定时切换的PageView
class ScrollPageView extends StatefulWidget {

  final bool isTimer;

  ///Page切换滑动的时间
  final Duration duration;

  ///多长时间切换一次Page
  final Duration delay;

  ///[PageView.allowImplicitScrolling]
  final bool allowImplicitScrolling;

  ///[PageView.restorationId]
  final String? restorationId;

  ///[PageView.scrollDirection]
  final Axis scrollDirection;

  ///[PageView.reverse]
  final bool reverse;

  ///[ScrollPageController.controller]
  final ScrollPageController controller;

  ///[PageView.pageSnapping]
  final ScrollPhysics? physics;

  ///[PageView.pageSnapping]
  final bool pageSnapping;

  ///[PageView.onPageChanged]
  final ValueChanged<int>? onPageChanged;

  ///[PageView.dragStartBehavior]
  final DragStartBehavior dragStartBehavior;

  ///[PageView.clipBehavior]
  final Clip? clipBehavior;

  // final List<Widget> children;

  ///指示点颜色
  final Color indicatorColor;

  ///选中的指示点颜色
  final Color checkedIndicatorColor;

  ///指示点半径
  final double indicatorRadius;

  ///PageView指示器位置
  final Alignment indicatorAlign;

  ///Indicator Padding
  final EdgeInsets indicatorPadding;

  ///[IndicatorWidgetBuilder]
  final IndicatorWidgetBuilder? indicatorWidgetBuilder;

  final margeGameList = <List<Datum>>[];

  ScrollPageView({
    Key? key,
    required this.controller,
    this.isTimer = true,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    this.allowImplicitScrolling = false,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    // this.children = const <Widget>[],
    this.delay = const Duration(seconds: 5),
    this.duration = const Duration(milliseconds: 800),
    this.indicatorColor = Colors.white,
    this.checkedIndicatorColor = Colors.deepOrange,
    this.indicatorRadius = 8,
    this.indicatorAlign = Alignment.bottomCenter,
    this.indicatorPadding = const EdgeInsets.all(16),
    this.indicatorWidgetBuilder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScrollPageViewState();
}

class ScrollPageViewState extends State<ScrollPageView> with WidgetsBindingObserver {
  bool isActive = true; //当前页面是否处于活跃状态（是否可视）
  bool isUserGesture = false; //用户是否正在拖拽页面
  bool isEnd = false; //用户拖拽是否结束
  bool isClick = false; //用户是否点击
  Timer? _timer;
  int currentIndex = 0;
  int realPosition = 0;
  List _children = [];
  final controller = Get.find<HomeLogic>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initWidget();
    start();
  }

  @override
  void dispose() {
    cancelTimer();
    widget.controller.get().dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed: //onResume
        isActive = true;
        start();
        break;
      case AppLifecycleState.paused: //onPause
        isActive = false;
        _stop();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => NotificationListener(
    onNotification: (notification) => _onNotification(notification),
    child: Stack(
      children: [
        PageView(
          scrollDirection: widget.scrollDirection,
          reverse: widget.reverse,
          controller: widget.controller.get(),
          physics: widget.physics,
          pageSnapping: widget.pageSnapping,
          onPageChanged: (index) => _onPageChanged(index),
          children:List.generate(
              _children.length,
                  (index) => _buildGroupItem(
                  _children[index], index)),
          dragStartBehavior: widget.dragStartBehavior,
          allowImplicitScrolling: widget.allowImplicitScrolling,
          restorationId: widget.restorationId,
          clipBehavior: widget.clipBehavior ?? Clip.none,
        ),
        Align(
          alignment: widget.indicatorAlign,
          child: Padding(
            padding: widget.indicatorPadding,
            child: Builder(
              builder: (context) {
                var builder = widget.indicatorWidgetBuilder?.call(
                  context,
                  realPosition,
                  _children.length - 2,
                );

                return builder ??
                    (isHorizontal()
                        ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildIndicators(),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildIndicators(),
                    ));
              },
            ),
          ),
        ),
      ],
    ),
  );

  _buildIndicators() {
    if (_children.isEmpty || _children.length < 2) {
      return <Widget>[];
    }
    var length = _children.length - 2;
    List<Widget> pointers = <Widget>[];
    for (var i = 0; i < length; i++) {
      pointers.add(_buildIndicator(i == realPosition));
    }
    return pointers;
  }

  ///指示器
  _buildIndicator(bool checked) {
    return AnimatedContainer(
      width: _getIndicatorWidth(checked),
      height: _getIndicatorHeight(checked),
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: checked ? widget.checkedIndicatorColor : widget.indicatorColor,
        borderRadius: BorderRadius.all(
          Radius.circular(widget.indicatorRadius),
        ),
      ),
    );
  }

  double _getIndicatorWidth(bool checked) {
    var small = widget.indicatorRadius;
    var large = widget.indicatorRadius * 3;
    return isHorizontal()
        ? checked
        ? large
        : small
        : small;
  }

  double _getIndicatorHeight(bool checked) {
    var small = widget.indicatorRadius;
    var large = widget.indicatorRadius * 3;
    return isHorizontal()
        ? small
        : checked
        ? large
        : small;
  }

  ///指示器是否为横向排列
  bool isHorizontal() =>
      widget.indicatorAlign == Alignment.center ||
          widget.indicatorAlign == Alignment.topCenter ||
          widget.indicatorAlign == Alignment.bottomCenter ||
          widget.indicatorAlign == Alignment.topLeft ||
          widget.indicatorAlign == Alignment.topRight ||
          widget.indicatorAlign == Alignment.bottomLeft ||
          widget.indicatorAlign == Alignment.bottomRight;

  ///指示器是否为纵向排列
  bool isVertical() =>
      widget.indicatorAlign == Alignment.centerLeft ||
          widget.indicatorAlign == Alignment.centerRight;

  ///初始化Page
  ///
  ///准备一个新的数据源list
  ///在原数据data的基础上，前后各添加一个view  data[data.length-1]、data[0]
  void _initWidget() {
    currentIndex = widget.controller.initialPage;
    if (controller.margeGameList.isEmpty) return;
    if (controller.margeGameList.length == 1) {
      _children.addAll(controller.margeGameList);
    } else {
      _children.add(controller.margeGameList[controller.margeGameList.length - 1]);
      _children.addAll(controller.margeGameList);
      _children.add(controller.margeGameList[0]);
    }
  }

  ///创建定时器
  void createTimer() {
    if (widget.isTimer) {
      cancelTimer();
      _timer = Timer.periodic(widget.delay, (timer) => _scrollPage());
    }
  }

  ///定时切换PageView的页面
  void _scrollPage() {
    ++currentIndex;
    var next = currentIndex % _children.length;
    if (widget.controller.get().hasClients) {
      widget.controller.get().animateToPage(
        next,
        duration: widget.duration,
        curve: Curves.ease,
      );
    }
  }

  ///page切换后的回调，及时修复索引
  _onPageChanged(int index) async {
    if (index == 0) {
      //当前选中的是第一个位置，自动选中倒数第二个位置
      currentIndex = _children.length - 2;
      await Future.delayed(const Duration(milliseconds: 400));
      if (widget.controller.get().hasClients) {
        widget.controller.get().jumpToPage(currentIndex);
        realPosition = currentIndex - 1;
      }
    } else if (index == _children.length - 1) {
      //当前选中的是倒数第一个位置，自动选中第一个索引
      currentIndex = 1;
      await Future.delayed(const Duration(milliseconds: 400));
      if (widget.controller.get().hasClients) {
        widget.controller.get().jumpToPage(currentIndex);
        realPosition = 0;
      }
    } else {
      currentIndex = index;
      realPosition = index - 1;
      if (realPosition < 0) realPosition = 0;
    }
    // print('realPosition: $realPosition');
    if (widget.onPageChanged != null) {
      widget.onPageChanged!(realPosition);
    }
    setState(() {});
  }

  ///开始定时滑动
  void start() {
    if (!widget.isTimer) return;
    if (!isActive) return;
    if (_children.length <= 1) return;
    createTimer();
  }

  ///停止定时滑动
  void _stop() {
    if (!widget.isTimer) return;
    cancelTimer();
  }

  ///取消定时器
  void cancelTimer() {
    _timer?.cancel();
  }

  ///Page滑动监听
  _onNotification(notification) {
    if (notification is ScrollStartNotification) {
      isEnd = false;
    } else if (notification is UserScrollNotification) {
      //用户滑动时回调顺序：start - user , end - user
      if (isEnd) {
        isUserGesture = false;
        start();
        return false;
      }
      isUserGesture = true;
      _stop();
    } else if (notification is ScrollEndNotification) {
      isEnd = true;
      if (isUserGesture) {
        start();
      }
    }
    return false;
  }

  Widget _buildGroupItem(List<Datum> ticketGroup, int groupIndex) {
    return Column(
      children: List.generate(ticketGroup.length, (index) {
        Map bgInfo = controller.imageMap[ticketGroup[index].lotteryCode];
        Datum item = ticketGroup[index];
        return Column(
          children: [
            KKHomeTicketItem(
              bgImageStr:bgInfo["bg_icon"],
              logoImageStr:bgInfo["logo_icon"],
              ballColors:bgInfo["ball_color"],
              tickInfo:item,
            openGame: (data) => controller.gamesOnTap('JCP', data),
            onUserInteracting:(data){
                    if(data){
                      start();
                    }else{
                      _stop();
                    }
                  },
              // key: PageStorageKey<String>("$index"),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        );
      }),
    );
  }
}
