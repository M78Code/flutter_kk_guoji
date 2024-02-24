import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Image.asset(Assets.homeImageTeachTitleOne),
          const SizedBox(
            height: 12,
          ),
          Image.asset(Assets.homeImageTeachOne),
          const SizedBox(
            height: 20,
          ),
          _buildTextOne(),
          const SizedBox(
            height: 34,
          ),
          Image.asset(Assets.homeImageTeachTwo),
          const SizedBox(
            height: 20,
          ),
          _buildTextTwo(),
          const SizedBox(
            height: 72,
          ),
          Image.asset(Assets.homeImageTeachTitleTwo),
          const SizedBox(
            height: 12,
          ),
          Image.asset(Assets.homeImageTeachThree),
          const SizedBox(
            height: 20,
          ),
          _buildTextThree(),
          const SizedBox(
            height: 72,
          ),
          Image.asset(Assets.homeImageJsTitleThree),
          const SizedBox(
            height: 12,
          ),
          Image.asset(Assets.homeImageJsFour),
          const SizedBox(
            height: 20,
          ),
          _buildTextFour(),
          const SizedBox(
            height: 34,
          ),
          Image.asset(Assets.homeImageTeachFive),
          const SizedBox(
            height: 20,
          ),
          _buildTextFive(),
          const SizedBox(
            height: 72,
          ),
          Image.asset(Assets.homeImageTeachTitleFour),
          const SizedBox(
            height: 12,
          ),
          Image.asset(Assets.homeImageTeachSix),
          const SizedBox(
            height: 20,
          ),
          _buildTextSix(),
          const SizedBox(
            height: 34,
          ),
          Image.asset(Assets.homeImageTeachEight),
          const SizedBox(
            height: 20,
          ),
          Text(
            ' · 财务会耐心指引，直到您充值完成。',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 53,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                  opacity: 0.06,
                  child: Container(
                    width: 80,
                    height: 1,
                    color: Colors.white,
                  )),
              const SizedBox(width: 21),
              Text(
                '已经到底啦~',
                style: TextStyle(
                  color: Color(0xFF686F83),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 21),
              Opacity(
                  opacity: 0.06,
                  child: Container(
                    width: 80,
                    height: 1,
                    color: Colors.white,
                  )),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildTextOne() {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: ' · 手机自带浏览器输入欧易官网地址并进入（ 地址：',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
              text: '  www.okx.com',
              style: const TextStyle(
                color: Color(0xFF389FFF),
                fontSize: 12,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('点击了');
                  _launchURL('https://www.okx.com');
                }),
          const TextSpan(
            text: ' ',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          const TextSpan(
            text: '）；\n',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          const TextSpan(
            text: ' · 进入官网后向下滑动页面，会出现下载浮窗，\n',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          const TextSpan(
            text: '  点击“下载”按钮即可下载/安装欧易APP；',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextTwo() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: ' · iOS系统点击“下载”按钮后，会跳转到App Store安装，\n',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '   且 ',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: 'App Store需登录',
            style: TextStyle(
              color: Color(0xFFFF3D00),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '外网苹果ID',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '才能下载，请留意',
            style: TextStyle(
              color: Color(0xFFFF3D00),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '。',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextThree() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: ' · 打开欧易APP或访问欧易网址 ',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
              text: 'www.okx.com',
              style: TextStyle(
                color: Color(0xFF389FFF),
                fontSize: 12,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('点击了');
                  _launchURL('https://www.okx.com');
                }),
          TextSpan(
            text: ' ',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '注册账号',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '，并在 \n    安全中心',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '绑定手机',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '；\n · 再欧易APP首页点击【去认证】，进行至少为',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: 'Lv2的高级认证',
            style: TextStyle(
              color: Color(0xFFFF3D00),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '。\n  （Lv1是上传姓名、身份证；Lv2需要人脸验证）\n',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '    ',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '如果您只进行Lv1认证，则只能交易99美金总额。',
            style: TextStyle(
              color: Color(0xFFE9AC35),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFour(){
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: ' · 点击首页中的',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '【买币】',
            style: TextStyle(
              color: Color(0xFFFF3D00),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '进入',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: 'C2C',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '或者',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '快捷交易',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '页面；\n · 输入您想要购买的金额，币种选择USDT，\n · 然后再选择您的付款方式（银行卡/微信/支付宝）；',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFive(){
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: ' · 查看',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '付款核实信息无误后',
            style: TextStyle(
              color: Color(0xFFFF3D00),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '，切换支付宝APP进行对该账号',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '\n    进行付款',
            style: TextStyle(
              color: Color(0xFFFF3D00),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '，\n · 付款后点击',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '【我已支付】',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '，卖家确认后会进行放币。',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSix(){
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: ' · 登录《博赢国际》在首页底部导航点击',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '【充值】',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '；\n · 在充值页面',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '复制财务TG账号',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '，打开',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: 'TG搜索',
            style: TextStyle(
              color: Color(0xFF05C066),
              fontSize: 12,
            ),
          ),
          TextSpan(
            text: '；',
            style: TextStyle(
              color: Color(0xFFB7C1DA),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
