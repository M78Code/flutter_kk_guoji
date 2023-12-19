import 'package:flutter/material.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/welfare_reward/welfare_list.dart';
import 'package:kkguoji/utils/route_util.dart';
import '../../../generated/assets.dart';
import '../../routes/routes.dart';

class WelfareRewardPage extends StatelessWidget {
  const WelfareRewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '福利奖励',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
            padding: const EdgeInsets.all(16.0),
            iconSize: 20,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/images/back_normal.png')),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      //在AppBar下方添加一条白色线
                      color: Color.fromRGBO(255, 255, 255, 0.06),
                      width: 1))),
        ),
        actions: const [
          Text(
            '88888888   ',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ClaimRecord(),
            AllAward(),
            SizedBox(height: 15),
            Divider(
              height: 18,
              color: Colors.black,
            ),
            SizedBox(height: 15),
            // RewardType(),
            SizedBox(height: 15),
            ListWidget(),
          ],
        ),
      ),
    );
  }
}

//已领取奖金总额、领取记录
class ClaimRecord extends StatelessWidget {
  const ClaimRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      height: 110,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.imagesIconClaimBg))),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 18),
              SizedBox(
                height: double.infinity,
                child: Image.asset(Assets.imagesIconReceivedMoney,
                    width: 44, height: 44),
              ),
              const SizedBox(width: 13),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '已领取奖金总额',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '88,686.00',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.only(
                  top: 35.5,
                  right: 18,
                ),
                width: 100,
                height: 39,
                decoration: ShapeDecoration(
                    color: const Color(0xFF2D374E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        RouteUtil.pushToView(Routes.claimRecordPage);
                      },
                      child: const Text(
                        '领取记录',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

//所有奖励
class AllAward extends StatelessWidget {
  const AllAward({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 0),
          height: 63,
          width: 110,
          decoration: BoxDecoration(
            color: const Color(0xFF2D374E),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '任务奖励总额',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(width: 5),
              Text(
                '0.00',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(width: 25),
        Container(
          height: 63,
          width: 110,
          decoration: BoxDecoration(
            color: const Color(0xFF2D374E),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '一般奖励总额',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '0.00',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          child: Container(
            height: 63,
            width: 110,
            decoration: BoxDecoration(
              color: const Color(0xFF2D374E),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '贵宾奖励总额',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '0.00',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          onTap: () {
            print('返水');
          },
        ),
      ],
    );
  }
}

//奖励类型
class RewardType extends StatelessWidget {
  const RewardType({super.key});

  @override
  Widget build(BuildContext context) {
    // List items = ['全部奖励', '任务奖励', '一般奖励', '贵宾奖励'];

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return FittedBox(
            child: Container(
              alignment: Alignment.center,
              width: 72,
              height: 30,
              color: const Color(0xFF222633),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: const Text(
                '全部奖励',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // itemCount: controller.messageList.length,
          itemCount: 13,
          itemBuilder: (context, index) {
            return Container(
              child: WelfareList(),
            );
          }),
    );
  }
}
