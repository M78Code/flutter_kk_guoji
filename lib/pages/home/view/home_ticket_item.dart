import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/api/games_api.dart';
import 'package:kkguoji/utils/json_util.dart';
import 'package:oktoast/oktoast.dart';

import '../../../common/models/jcp_bet_model.dart';
import '../../../model/home/base_model.dart';
import '../../../model/home/jcp_game_model.dart';
import '../../../routes/routes.dart';
import '../../../services/event_bus_util.dart';
import '../../../services/event_service.dart';
import '../../../services/user_service.dart';
import '../../../utils/function.dart';
import '../../../utils/route_util.dart';
import '../../../widget/show_toast.dart';

const kChangeMainPageEvent = 'kChangeMainPageEvent';

class KKHomeTicketItem extends StatefulWidget {
  final String bgImageStr;
  final String logoImageStr;
  final Datum tickInfo;
  final List<Color> ballColors;
  final ParamSingleCallback<String> openGame;
  ///用户点击行为重置轮播剩余时间为5秒的回调
  late ParamSingleCallback<bool> onUserInteracting;
  // late ParamSingleCallback<bool> showLoading;

  KKHomeTicketItem({super.key,required this.bgImageStr, required this.logoImageStr,required  this.ballColors,
    required  this.tickInfo,required  this.openGame,required this.onUserInteracting,});

  // KKHomeTicketItem(this.bgImageStr, this.logoImageStr, this.ballColors,
  //     this.tickInfo, this.openGame,this.onUserInteracting,
  //     {Key? key})
  //     : super(key: key);

  @override
  State<KKHomeTicketItem> createState() => _KKHomeTicketItemState();
}

class _KKHomeTicketItemState extends State<KKHomeTicketItem>
    with AutomaticKeepAliveClientMixin {
  String periodsNumber = "";
  num endTime = 0;
  List<String> timeList = ["0", "0", "0", "0", "0", "0"];
  late TextEditingController _numberController;
  late List<JcpBetModel> betList = [];
  final userService = Get.find<UserService>();

  late DateTime serverTime;
  late Duration countdownDuration;
  late Timer timer;
  bool isCountdownFinished = false;
  final eventBus = EventBus();
  FocusNode _focusNode = FocusNode();
  late Connectivity _connectivity;
  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivity = Connectivity();
    _connectivityResult = ConnectivityResult.none;
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
        print('网络状态：${_connectivityResult}');
      });
    });
    betList = [];
    // print('已选中列表：${JsonUtil.encodeObj(betList)}');
    _numberController = TextEditingController(text: getDefaultAmount());
    periodsNumber = widget.tickInfo.last!.periodsNumber.toString();
    endTime = widget.tickInfo.current?.autoCloseDate ?? 0;
    if (widget.tickInfo.current!.status == 10 ||
        widget.tickInfo.current!.status == 0) {
      if (endTime * 1000 >
          num.parse('${DateTime.now().millisecondsSinceEpoch}')) {
        timer = Timer.periodic(const Duration(seconds: 1), _updateCountdown);
      }
    }
    eventBus.stream.listen((event) {
      if (event == '$kChangeMainPageEvent${widget.tickInfo.lotteryCode}') {
        endTime = widget.tickInfo.current?.autoCloseDate ?? 0;
        print('$kChangeMainPageEvent${widget.tickInfo.lotteryCode}更新了1');
        if (widget.tickInfo.current!.status == 10 ||
            widget.tickInfo.current!.status == 0) {
          if (endTime * 1000 >
              num.parse('${DateTime.now().millisecondsSinceEpoch}')) {
            print('$kChangeMainPageEvent${widget.tickInfo.lotteryCode}更新了2');
            timer =
                Timer.periodic(const Duration(seconds: 1), _updateCountdown);
          }else{
            print('$kChangeMainPageEvent${widget.tickInfo.lotteryCode}更新了3');
          }
        }
        setState(() {});
      }
    });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // 输入框获得焦点时，暂停轮播
        widget.onUserInteracting(false);
      } else {
        // 输入框失去焦点时，恢复轮播
        widget.onUserInteracting(true);
      }
    });
  }

  void updateCountdownDuration() {
    final now = DateTime.now();
    countdownDuration =
        serverTime.isAfter(now) ? serverTime.difference(now) : Duration.zero;

    if (countdownDuration == Duration.zero) {
      isCountdownFinished = true;
      timer.cancel();
    }
  }

  void _updateCountdown(Timer timer) {
    startEndTime();
    if (mounted) {
      setState(() {});
    }
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);
    return '$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Container(
        color: const Color(0xFF0F1921),
        child: Column(
          children: [
            Container(
              height: 64,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                image: DecorationImage(
                    image: AssetImage(widget.bgImageStr), fit: BoxFit.cover),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.logoImageStr,
                    width: 44,
                    height: 44,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.tickInfo.lotteryName.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                          text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "第",
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.0),
                          ),
                          TextSpan(
                            text:
                                widget.tickInfo.last!.periodsNumber.toString(),
                            style: const TextStyle(
                                color: Color(0xFFF4B81C), fontSize: 11),
                          ),
                          const TextSpan(
                            text: "期",
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.0),
                          ),
                        ],
                      )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: getTicketState(),
                        child: Container(
                            color: const Color(0xFFFF563F),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0, vertical: 2),
                              child: Text(
                                getTicketStateString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/home_ticket_hit_icon.png",
                            width: 10.5,
                            height: 12,
                          ),
                          _buildTimeItem(0),
                          const SizedBox(
                            width: 2,
                          ),
                          _buildTimeItem(1),
                          const Text(
                            ":",
                            style: TextStyle(
                                color: Color(0xFF2F03AB), fontSize: 18),
                          ),
                          _buildTimeItem(2),
                          const SizedBox(
                            width: 2,
                          ),
                          _buildTimeItem(3),
                          const Text(
                            ":",
                            style: TextStyle(
                                color: Color(0xFF2F03AB), fontSize: 18),
                          ),
                          _buildTimeItem(4),
                          const SizedBox(
                            width: 2,
                          ),
                          _buildTimeItem(5),
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        widget.openGame(widget.tickInfo.lotteryCode ?? '');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 255, 255, 0.36),
                            )),
                        width: 48,
                        height: 46,
                        child: const Center(
                          child: Text(
                            "进入\n游戏",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF), fontSize: 12),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.04, -1.00),
                  end: Alignment(-0.04, 1),
                  colors: [Color(0xFF2E374E), Color(0xFF232B43)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(67),
                    bottomRight: Radius.circular(67),
                  ),
                ),
              ),
              child:
                  _buildDrawingBall(widget.tickInfo.last?.drawingResult ?? ''),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.tickInfo.play!.cachePlayList!.isNotEmpty
                    ? List.generate(widget.tickInfo.play!.cachePlayList!.length,
                        (index) {
                        return _buildOddsItem(
                            widget.tickInfo.play!.cachePlayList![index]);
                      })
                    : List.generate(
                        widget.tickInfo.play!.lotteryPlayTypeList!.length,
                        (index) {
                        return _buildOddsItemNN(
                            widget.tickInfo.play!.lotteryPlayTypeList![index]);
                      })),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const ShapeDecoration(
                color: Color(0xFF1A1F2D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 101,
                        height: 31,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.5),
                          color: const Color(0xFF4338C9),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: TextButton(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero)),
                                onPressed: () {
                                  decrementNumber();
                                },
                                child: Image.asset(
                                  "assets/images/home_sub_icon.png",
                                  width: 12,
                                  height: 2.5,
                                ),
                              ),
                            ),
                            Container(
                              width: 35,
                              height: 26,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF30298B),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: const Color(0xFF9FC1EA))),
                              child: Center(
                                child: TextField(
                                  focusNode: _focusNode,
                                  controller: _numberController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  enableInteractiveSelection: false, //禁止复制粘贴
                                  maxLines: 1,
                                  inputFormatters: [LengthLimitingTextInputFormatter(8)],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  cursorColor: Colors.white,  //光标颜色
                                  decoration: const InputDecoration(
                                    // border: InputBorder.none, // 设置为 none 去掉下划线
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0, color: Colors.transparent)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0, color: Colors.transparent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0, color: Colors.transparent)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0, color: Colors.transparent)),
                                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              height: 31,
                              child: TextButton(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero),
                                    alignment: Alignment.center),
                                onPressed: () {
                                  incrementNumber();
                                },
                                child: Image.asset(
                                  "assets/images/home_add_icon.png",
                                  width: 12.5,
                                  height: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        width: 90,
                        height: 31,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.5),
                            gradient: widget.tickInfo.current!.status == 0
                                ? const LinearGradient(colors: [
                                    Color(0xFF3D35C6),
                                    Color(0xFF6C4FE0)
                                  ])
                                : const LinearGradient(colors: [
                                    Color(0xFF686F83),
                                    Color(0xFF686F83)
                                  ])),
                        child: TextButton(
                          onPressed: () {
                            if (widget.tickInfo.current!.status == 0) {
                              if (UserService.to.isLogin == false) {
                                RouteUtil.pushToView(Routes.loginPage);
                                return;
                              }
                              if (betList.isNotEmpty) {
                                if (_numberController.text.isNotEmpty) {
                                  widget.onUserInteracting(true);
                                  betGame();
                                }
                              } else {
                                ShowToast.showToast('请选择下注类型');
                              }
                            }
                          },
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.zero)),
                          child: const Text(
                            "快捷投注",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  betGame() async {
    if(_connectivityResult==ConnectivityResult.none){
      ShowToast.showToast('已断开连接，请检查您的网络连接是否正常！');
      return;
    }
    // widget.showLoading(true);
    betList.forEach((element) {
      element.betAmount = _numberController.text;
    });
    BaseModel? baseModel =
        await GamesApi.betGame(betList, widget.tickInfo.lotteryCode ?? '');
    if (baseModel?.code == 200) {
      ShowToast.showToast('下注成功');
      userService.fetchUserMoney();
      // widget.showLoading(false);
    } else {
      ShowToast.showToast(baseModel!.message);
      // widget.showLoading(false);
    }
  }

  Widget _buildDrawingBall(String number) {
    var split = number.split(',');
    bool isLhc = widget.tickInfo.lotteryCode == "XGLHC";
    if (isLhc) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(split.length, (index) {
            return _buildLhcBall(split[index]);
          }));
    } else {
      List<String> modifiedList = [];
      for (int i = 0; i < split.length; i++) {
        modifiedList.add(split[i]);
        if (i < split.length - 1) {
          modifiedList.add('+');
        }
        if (i == split.length - 1) {
          modifiedList.add('=');
          modifiedList.add(calculateSum(split).toString());
        }
      }
      return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(modifiedList.length, (index) {
            if (index % 2 == 0) {
              return _buildItemBall(modifiedList[index], widget.ballColors);
            } else {
              return _buildSymbolView(modifiedList[index]);
            }
          }));
    }
  }

  int calculateSum(List<String> numbers) {
    return numbers.map((str) => int.tryParse(str) ?? 0).reduce((a, b) => a + b);
  }

  Widget _buildLhcBall(String numString) {
    return Container(
      width: 28,
      height: 28,
      child: Stack(
        children: [
          Image.asset(
            getLhcBallIcon(numString),
            width: 28,
            height: 28,
          ),
          Center(
            child: Text(
              numString,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemBall(String numString, List<Color> colors) {
    return Container(
      width: 28,
      height: 28,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.00, -1.00),
          end: const Alignment(0, 1),
          colors: [Colors.white, colors[0]],
        ),
        shape: OvalBorder(
          side: BorderSide(width: 2, color: colors[1]),
        ),
      ),
      child: Center(
        child: Text(
          numString,
          style: TextStyle(color: colors[2], fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSymbolView(String string) {
    return Container(
      width: 26,
      height: 26,
      child: Center(
        child: Text(
          string,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildTimeItem(int index) {
    return Container(
        width: 15,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
        )),
        child: Center(
          child: Text(
            timeList[index],
            style: const TextStyle(color: Color(0xFF2F03AB), fontSize: 18),
          ),
        ));
  }

  Widget _buildOddsItem(CachePlayList playInfo) {
    String odds = playInfo.odds.toString();
    odds = odds.contains('.')
        ? (odds.endsWith('0') ? odds.replaceAll(RegExp(r'\.0*$'), '') : odds)
        : odds;
    String maxOdds = playInfo.maxOdds.toString();
    maxOdds = maxOdds.contains('.')
        ? (maxOdds.endsWith('0')
            ? maxOdds.replaceAll(RegExp(r'\.0*$'), '')
            : maxOdds)
        : maxOdds;
    bool isPCNN = widget.tickInfo.lotteryCode == "PCNN";
    bool isSelect = playInfo.isSelect ?? false;
    String content = "";
    // print('xiaoan 赔率选项：$isPCNN${widget.tickInfo.lotteryCode}');
    if (isPCNN) {
      content =
          "${playInfo.playName}:${playInfo.odds.toString()}-${playInfo.maxOdds.toString()}";
      print('xiaoan 赔率选项：$content');
    } else {
      if (widget.tickInfo.lotteryCode == 'JNDEB' ||
          widget.tickInfo.lotteryCode == 'JNDSI' ||
          widget.tickInfo.lotteryCode == 'JNDWU') {
        content = "${playInfo.playName}: $maxOdds";
      } else {
        content = "${playInfo.playName}: $odds";
      }
    }
    return GestureDetector(
      onTap: () {
        widget.onUserInteracting(true);
        if (!isSelect) {
          playInfo.isSelect = true;
          betList.add(JcpBetModel(
              lotteryCode: widget.tickInfo.lotteryCode ?? '',
              playTypeCode: playInfo.playTypeCode ?? '',
              sonPlayTypeCode: playInfo.sonPlayTypeCode ?? '',
              playCode: playInfo.playCode ?? '',
              betContent: playInfo.playCode ?? '',
              betAmount: _numberController.text));
        } else {
          playInfo.isSelect = false;
          betList
              .removeWhere((element) => element.playCode == playInfo.playCode);
        }
        setState(() {});
        print('以选中选项：${JsonUtil.encodeObj(betList)}');
      },
      child: Container(
        width: 67,
        height: 38,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF2E374E),
            border: Border.all(
                width: 2,
                color: playInfo.isSelect ?? false
                    ? Color(0xFF755EFF)
                    : Color(0xFF2E374E))),
        child: Center(
          child: Text(
            content,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildOddsItemNN(Play playInfo) {
    bool isSelect = playInfo.cachePlayList?[0].isSelect ?? false;
    bool isPCNN = widget.tickInfo.lotteryCode == "PCNN";
    String content = "";
    if (isPCNN) {
      content =
          "${playInfo.cachePlayList?[0].playName}:${playInfo.cachePlayList?[0].odds?.toInt()}-${playInfo.cachePlayList?[0].maxOdds?.toInt()}";
    } else {
      content =
          "${playInfo.cachePlayList?[0].playName}: ${playInfo.cachePlayList?[0].odds.toString()}";
    }
    return GestureDetector(
      onTap: () {
        widget.onUserInteracting(true);
        if (!isSelect) {
          playInfo.cachePlayList?[0].isSelect = true;
          betList.add(JcpBetModel(
              lotteryCode: widget.tickInfo.lotteryCode ?? '',
              playTypeCode: playInfo.cachePlayList?[0].playTypeCode ?? '',
              sonPlayTypeCode: playInfo.cachePlayList?[0].sonPlayTypeCode ?? '',
              playCode: playInfo.cachePlayList?[0].playCode ?? '',
              betContent: playInfo.cachePlayList?[0].playCode ?? '',
              betAmount: _numberController.text));
        } else {
          playInfo.cachePlayList?[0].isSelect = false;
          betList.removeWhere((element) =>
              element.playCode == playInfo.cachePlayList?[0].playCode);
        }
        setState(() {});
        print('以选中选项：${JsonUtil.encodeObj(betList)}');
      },
      child: Container(
        width: 70,
        height: 38,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFF2E374E),
            border: Border.all(
                width: 2,
                color: playInfo.cachePlayList?[0].isSelect ?? false
                    ? Color(0xFF755EFF)
                    : Color(0xFF2E374E))),
        child: Center(
          child: Text(
            content,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  void startEndTime() {
    DateTime now = DateTime.now();
    int time = now.millisecondsSinceEpoch;
    if (endTime * 1000 > time) {
      DateTime haveTime = DateTime.fromMillisecondsSinceEpoch(
          (endTime * 1000 - time).toInt(),
          isUtc: true);
      String timestr = formatDate(haveTime, [HH, nn, ss]);

      timeList = timestr.split("");
      // widget.tickInfo.current!.status = 0;
    } else {
      widget.tickInfo.current!.status = 4;
      timer.cancel();
    }
    // if (mounted) {
    //   setState(() {});
    // }
  }

  bool getTicketState() {
    // print(
    //     '开奖状态：${widget.tickInfo.lotteryCode} ${widget.tickInfo.current!.status}');
    if (widget.tickInfo.current!.status == 4 ||
        widget.tickInfo.current!.status == 10 ||
        widget.tickInfo.current!.status == 9 ||
        widget.tickInfo.current!.status == 1) {
      return true;
    } else {
      return false;
    }
  }

  String getTicketStateString() {
    if (widget.tickInfo.current!.status == 4 ||
        widget.tickInfo.current!.status == 9 ||
        widget.tickInfo.current!.status == 1) {
      return '已封盘';
    } else if (widget.tickInfo.current!.status == 10) {
      return '开奖中';
    } else {
      return '';
    }
  }

  void incrementNumber() {
    widget.onUserInteracting(true);
    int currentValue = int.tryParse(_numberController.text) ?? 0;
    int newValue = currentValue + 1;
    _numberController.text = newValue.toString();
  }

  void decrementNumber() {
    widget.onUserInteracting(true);
    int currentValue = int.tryParse(_numberController.text) ?? 0;
    int newValue = currentValue - 1;

    // Ensure the new value is at least 0
    if (newValue >= 0) {
      _numberController.text = newValue.toString();
    }
  }

  String getDefaultAmount() {
    if (widget.tickInfo.lotteryCode == "PCNN") {
      return '1';
    } else if (widget.tickInfo.lotteryCode == "PCBJL") {
      return '10';
    } else {
      return '2';
    }
  }

  String getLhcBallIcon(String numberString) {
    int number = int.parse(numberString);
    switch (number) {
      case 1:
      case 2:
      case 7:
      case 8:
      case 12:
      case 13:
      case 18:
      case 19:
      case 23:
      case 24:
      case 29:
      case 30:
      case 34:
      case 35:
      case 40:
      case 45:
      case 46:
        return 'assets/images/home/ball_red.png';
      case 3:
      case 4:
      case 9:
      case 10:
      case 14:
      case 15:
      case 20:
      case 25:
      case 26:
      case 31:
      case 36:
      case 37:
      case 41:
      case 42:
      case 47:
      case 48:
        return 'assets/images/home/ball_purple.png';
    }
    return 'assets/images/home/ball_green.png';
  }

  ///pageview翻页时保持页面状态
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _numberController.dispose();
    // eventBus.dispose();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      setState(() {
        _connectivityResult = connectivityResult;
        print('网络状态：${_connectivityResult}');
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
