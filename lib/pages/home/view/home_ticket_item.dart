
import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../../../model/home/jcp_game_model.dart';


class KKHomeTicketItem extends StatefulWidget {
  final String bgImageStr;
  final String logoImageStr;
  final Datum tickInfo;
  const KKHomeTicketItem(@required this.bgImageStr,
      @required this.logoImageStr,
      @required this.tickInfo, {super.key});

  @override
  State<KKHomeTicketItem> createState() => _KKHomeTicketItemState();
}

class _KKHomeTicketItemState extends State<KKHomeTicketItem> {

  String periodsNumber = "";
  num endTime = 0;
  bool isShowStatus = false;
  List <String> timeList = ["0", "0", "0", "0", "0", "0"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.tickInfo == null) {
      periodsNumber = widget.tickInfo.current!.periodsNumber.toString();
      endTime = widget.tickInfo.current?.autoCloseDate ?? 0;
      isShowStatus = widget.tickInfo.current?.status != 4;
    }
    if(endTime * 1000 > DateTime.now().millisecondsSinceEpoch) {
      Timer.periodic(const Duration(seconds: 1), (Timer timer){
         startEndTime();
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0F1921),
      child: Column(
        children: [
          Container(
            height: 64,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration:  BoxDecoration(
              image: DecorationImage(image: AssetImage(widget.bgImageStr), fit: BoxFit.cover),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(widget.logoImageStr, width: 44, height: 44,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.tickInfo.lotteryName.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),),
                    const SizedBox(height: 5,),
                    RichText(text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "第",
                          style: TextStyle(color: Colors.white, fontSize: 11.0),
                        ),
                        TextSpan(
                          text: periodsNumber,
                          style: const TextStyle(color: Color(0xFFF4B81C), fontSize: 11),
                        ),
                        const TextSpan(
                          text: "期",
                          style: TextStyle(color: Colors.white, fontSize: 11.0),
                        ),
                      ],
                    )) ,

                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        color: const Color(0xFFFF563F),
                        child: Offstage(
                          offstage: true,
                          child: const Text("封盘中", style: TextStyle(color: Colors.white, fontSize: 11),),
                        )
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Image.asset("assets/images/home_ticket_hit_icon.png", width: 10.5, height: 12,),
                        _buildTimeItem(0),
                        const SizedBox(width: 2,),
                        _buildTimeItem(1),
                        const Text(":", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                        _buildTimeItem(2),
                        const SizedBox(width: 2,),
                        _buildTimeItem(3),
                        const Text(":", style: TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
                        _buildTimeItem(4),
                        const SizedBox(width: 2,),
                        _buildTimeItem(5),


                      ],
                    )
                  ],
                ),
                GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.36), )
                      ),
                      width: 48,
                      height: 46,
                      child: const Center(
                        child: Text("进入\n游戏", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),),
                      ),
                    )
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 40),
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
              ),),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 26, height: 26,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                    ),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                Container(
                  width: 26, height: 26,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                    ),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,

                  ),
                  child: const Center(
                    child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                Container(
                  width: 26, height: 26,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                    ),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,

                  ),
                  child: const Center(
                    child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                Container(
                  width: 26, height: 26,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                    ),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,

                  ),
                  child: const Center(
                    child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                Container(
                  width: 26, height: 26,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                    ),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,

                  ),
                  child: const Center(
                    child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
                Container(
                  width: 26, height: 26,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5D3A), Color(0xFFB70000)],
                    ),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.circle,

                  ),
                  child: const Center(
                    child: Text("1", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(widget.tickInfo.play!.cachePlayList!.length, (index) {
              return _buildOddsItem(widget.tickInfo.play!.cachePlayList![index]);
            })
          ),
          const SizedBox(height: 20,),
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
                SizedBox(height: 20,),
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
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 30,
                            child: TextButton(
                              style:  const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                              onPressed: (){

                              },
                              child: Image.asset("assets/images/home_sub_icon.png", width: 12, height: 2.5,),
                            ),

                          ),
                          Container(
                            width: 35,
                            height: 22,
                            decoration: BoxDecoration(
                                color: const Color(0xFF30298B),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: const Color(0xFF9FC1EA))
                            ),
                            child: const TextField(
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                              cursorColor: Colors.white,
                            ),

                          ),
                          SizedBox(
                            width: 30,
                            height: 31,
                            child: TextButton(
                              style:  const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero), alignment: Alignment.center),
                              onPressed: (){

                              },
                              child: Image.asset("assets/images/home_add_icon.png", width: 12.5, height: 15,),
                            ),

                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 25,),
                    Container(
                      width: 90,
                      height: 31,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.5),
                          gradient: const LinearGradient(
                              colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]
                          )
                      ),
                      child: TextButton(
                        onPressed: (){

                        }, style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                        child: const Text("快捷投注", style: TextStyle(color: Colors.white, fontSize: 14),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),

        ],
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
            )
        ),
        child: Center(
          child: Text(timeList[index], style: const TextStyle(color: Color(0xFF2F03AB), fontSize: 18),),
        )
    );
  }

  Widget _buildOddsItem(CachePlayList playInfo) {
    bool isPCNN = widget.tickInfo.lotteryCode == "PCNN";
    String content = "";
    if(isPCNN) {
      content = "${playInfo.playName}:${playInfo.odds}-${playInfo.maxOdds}";
    }else {
      content = "${playInfo.playName}: ${playInfo.odds}";
    }
    return Container(
      width: 67,
      height: 38,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFF2E374E),
      ),
      child: Center(
        child: Text(content, style: const TextStyle(color: Colors.white, fontSize: 12),),
      ),
    );

  }


  void startEndTime() {
    DateTime now = DateTime.now();
    int time = now.millisecondsSinceEpoch;

    DateTime haveTime = DateTime.fromMillisecondsSinceEpoch((endTime*1000-time).toInt(), isUtc: true);
    String timestr = formatDate(haveTime, [HH,nn,ss]);

    timeList = timestr.split("");
    if(mounted) {
      setState(() {});
    }
  }
}
