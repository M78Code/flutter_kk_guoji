import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshListWidget<T> extends StatefulWidget {
  final bool enablePullUp;
  final bool enablePullDown;
  final Widget? listViewChild;

  final List<T> data;
  final Widget Function(int index) itemBuilder;

  final Future<List<T>> Function(int index) onRefresh;
  final Future<List<T>> Function(int index) onLoadMore;

  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const RefreshListWidget({
    super.key,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.shrinkWrap = false,
    required this.data,
    required this.onRefresh,
    required this.onLoadMore,
    this.physics,
    this.listViewChild,
    required this.itemBuilder,
  });

  @override
  State<RefreshListWidget> createState() => _RefreshListWidgetState();
}

class _RefreshListWidgetState extends State<RefreshListWidget> {
  late RefreshController _refreshController;
  late int _pageIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _pageIndex = 1;
  }

  Future<void> _refresh() async {
    _pageIndex = 1;
    final newData = await widget.onRefresh(_pageIndex);
    setState(() {
      widget.data.clear();
      widget.data.addAll(newData);
      _refreshController
        ..refreshCompleted()
        ..resetNoData();
    });
  }

  Future<void> _loadMore() async {
    final newData = await widget.onLoadMore(_pageIndex + 1);
    if (newData.isNotEmpty) {
      setState(() {
        widget.data.addAll(newData);
      });
      _pageIndex++;
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: widget.enablePullUp,
      enablePullDown: widget.enablePullDown,
      onRefresh: () => _refresh(),
      onLoading: () => _loadMore(),
      header: const ClassicHeader(
        idleText: "下拉刷新",
        releaseText: "释放刷新",
        completeText: "刷新完成",
        refreshingText: "加载中......",
      ),
      footer: const ClassicFooter(
        idleText: "上拉加载更多",
        canLoadingText: "释放加载更多",
        loadingText: "加载中......",
      ),
      child: widget.listViewChild ??
          ListView.builder(
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap,
            itemCount: widget.data.length,
            itemBuilder: (_, index) => widget.itemBuilder(index),
            // itemBuilder: (context, index) => InkWellView(
            //   child: widget.itemBuilder.call(widget.data[index], index),
            //   // child: widget.itemBuilder(widget.data[index], index),
            // ),
          ),
    );
  }
}
