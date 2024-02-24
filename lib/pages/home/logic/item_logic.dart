import 'dart:async';
import 'dart:ui';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/api/games_api.dart';
import '../../../common/models/jcp_bet_model.dart';
import '../../../model/home/base_model.dart';
import '../../../model/home/jcp_game_model.dart';
import '../../../services/user_service.dart';
import '../../../utils/function.dart';
import '../../../widget/show_toast.dart';

class ItemLogic extends GetxController {
  var margeGameListNew = <List<Datum>>[].obs;
  late RxString bgImageStr = ''.obs;
  late RxString logoImageStr = ''.obs;
  late Rx<Datum> tickInfo=Datum().obs;
  var ballColors = <Color>[].obs;

  RxString periodsNumber = "".obs;
  final endTime = RxNum(0);
  List<String> timeList = ["0", "0", "0", "0", "0", "0"].obs;
  late TextEditingController numberController;
  var betList = <JcpBetModel>[].obs;
  final userService = Get.find<UserService>();

  late DateTime serverTime;
  late Duration countdownDuration;
  late Timer timer;
  bool isCountdownFinished = false;

  @override
  void onInit() {
    super.onInit();
  }

  void processData() {
    // print('已选中列表：${JsonUtil.encodeObj(betList)}');
    // if(tickInfo!=null){
    //   Map bgInfo = bgImageStr.value = imageMap[tickInfo.lotteryCode];
    //   bgImageStr.value = bgInfo["bg_icon"];
    //   logoImageStr.value = bgInfo["logo_icon"];
    //   ballColors = bgInfo["ball_color"];
    // }
    numberController = TextEditingController(text: getDefaultAmount());
    periodsNumber.value = tickInfo.value.last!.periodsNumber.toString();
    endTime.value = tickInfo.value.current?.autoCloseDate ?? 0;
    if (!getTicketState()) {
      if (endTime * 1000 > DateTime.now().millisecondsSinceEpoch) {
        // Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        //   startEndTime();
        // });
        timer = Timer.periodic(const Duration(seconds: 1), _updateCountdown);
      }
    }
  }

  String getDefaultAmount() {
    if (tickInfo.value.lotteryCode == "PCNN") {
      return '1';
    } else if (tickInfo.value.lotteryCode == "PCBJL") {
      return '10';
    } else {
      return '2';
    }
  }

  bool getTicketState() {
    print(
        '开奖状态：${tickInfo.value.lotteryCode} ${tickInfo.value.current!.status}');
    if (tickInfo.value.current!.status == 4 ||
        tickInfo.value.current!.status == 10 ||
        tickInfo.value.current!.status == 9 ||
        tickInfo.value.current!.status == 1) {
      return true;
    } else {
      return false;
    }
  }

  String getTicketStateString() {
    if (tickInfo.value.current!.status == 4 ||
        tickInfo.value.current!.status == 9 ||
        tickInfo.value.current!.status == 1) {
      return '已封盘';
    } else if (tickInfo.value.current!.status == 10) {
      return '开奖中';
    } else {
      return '';
    }
  }

  void _updateCountdown(Timer timer) {
    startEndTime();
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
      tickInfo.value.current!.status = 4;
    }
    update();
  }

  betGame() async {
    betList.forEach((element) {
      element.betAmount = numberController.text;
    });

    BaseModel? baseModel =
        await GamesApi.betGame(betList, tickInfo.value.lotteryCode ?? '');
    if (baseModel?.code == 200) {
      ShowToast.showToast('下注成功');
      userService.fetchUserMoney();
    } else {
      ShowToast.showToast(baseModel!.message);
    }
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  int calculateSum(List<String> numbers) {
    return numbers.map((str) => int.tryParse(str) ?? 0).reduce((a, b) => a + b);
  }

  void incrementNumber() {
    int currentValue = int.tryParse(numberController.text) ?? 0;
    int newValue = currentValue + 1;
    numberController.text = newValue.toString();
  }

  void decrementNumber() {
    int currentValue = int.tryParse(numberController.text) ?? 0;
    int newValue = currentValue - 1;

    // Ensure the new value is at least 0
    if (newValue >= 0) {
      numberController.text = newValue.toString();
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

  Map imageMap = {
    "XGLHC": {
      "bg_icon": "assets/images/home_xianggangliuhecai.png",
      "logo_icon": "assets/images/home_liuhecai_icon.png",
      'ball_color': [
        const Color(0xFFFF5D3A),
        const Color(0xFFB70000),
        const Color(0xFFB70000)
      ]
    },
    "PCNN": {
      "bg_icon": "assets/images/home_pcniuniu.png",
      "logo_icon": "assets/images/home_pcniuniu_icon.png",
      'ball_color': [
        const Color(0xFFF0F8FF),
        const Color(0xFF06873A),
        const Color(0xFF06873A)
      ]
    },
    "PCBJL": {
      "bg_icon": "assets/images/home_pcbaijiale.png",
      "logo_icon": "assets/images/home_pcbaijiale_icon.png",
      'ball_color': [
        const Color(0xFFF0F8FF),
        const Color(0xFF1A8BD7),
        const Color(0xFF1A8BD7)
      ]
    },
    "JNDSI": {
      "bg_icon": "assets/images/home_jianada42.png",
      "logo_icon": "assets/images/home_jianada42_icon.png",
      'ball_color': [
        const Color(0xFFF0F8FF),
        const Color(0xFFA21111),
        const Color(0xFFE32D2D)
      ]
    },
    "JNDWU": {
      "bg_icon": "assets/images/home_jianada5.png",
      "logo_icon": "assets/images/home_jianada50_icon.png",
      'ball_color': [
        const Color(0xFFF0F8FF),
        const Color(0xFFA21111),
        const Color(0xFFE32D2D)
      ]
    },
    "JNDWP": {
      "bg_icon": "assets/images/home_jianadawangpan.png",
      "logo_icon": "assets/images/home_jianadawangpan_icon.png",
      'ball_color': [
        const Color(0xFFF0F8FF),
        const Color(0xFF831AD7),
        const Color(0xFFA32FFF)
      ]
    },
    "JNDEB": {
      "bg_icon": "assets/images/home_jianada28.png",
      "logo_icon": "assets/images/home_jianada28_icon.png",
      'ball_color': [
        const Color(0xFFF0F8FF),
        const Color(0xFFA21111),
        const Color(0xFFE32D2D)
      ]
    },
    "JNDSSC": {
      "bg_icon": "assets/images/home_jianadashishicai.png",
      "logo_icon": "assets/images/home_jianadashishicai_icon.png",
      'ball_color': [
        const Color(0xFFF0F8FF),
        const Color(0xFFA21111),
        const Color(0xFFE32D2D)
      ]
    },
    "JNDLHC": {
      "bg_icon": "assets/images/home_xianggangliuhecai.png",
      "logo_icon": "assets/images/home_liuhecai_icon.png",
      'ball_color': [
        const Color(0xFFFF5D3A),
        const Color(0xFFB70000),
        const Color(0xFFB70000)
      ]
    },
  };
}
