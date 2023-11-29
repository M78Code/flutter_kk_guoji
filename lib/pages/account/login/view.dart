
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/login/logic.dart';

import '../../../routes/routes.dart';
import '../../../utils/route_util.dart';
import '../../../widget/custom_input_field.dart';

class KKLoginPage extends StatefulWidget {
  const KKLoginPage({super.key});

  @override
  State<KKLoginPage> createState() => _KKLoginPageState();
}

class _KKLoginPageState extends State<KKLoginPage> {

  late LoginLogic controller = Get.find<LoginLogic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.lazyPut(() => LoginLogic());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/register_bg.png"),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xED2E374C)
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 48,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: TextButton(onPressed: (){

                      }, child: Image.asset("assets/images/back_normal.png", width: 40, height: 40,)),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Image.asset("assets/images/regist_top_logo.png", width: 163, height: 45,),
                      const SizedBox(height: 60,),
                      CustomInputField("assets/images/account_icon.png", "请输入用户名",),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return CustomInputField("assets/images/password_icon.png", "请输入密码",
                          isObscureText: controller.psdObscure.value, rightWidget: GestureDetector(
                            child: SizedBox(width: 60,
                              child: Image.asset(controller.psdObscure.value ? "assets/images/password_off.png":"assets/images/password_on.png", width: 30, height: 30,),),
                            onTap: () {
                              controller.showPassword();
                            },
                          ),);
                      }),
                      const SizedBox(height: 20,),
                      CustomInputField("assets/images/ver_code.png", "请输入验证码（选填）",),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            return GestureDetector(
                              child: Row(
                                children: [
                                  Image.asset( controller.savePassword.value ?
                                  "assets/images/privacy_btn_selected.png":
                                  "assets/images/privacy_btn_normal.png",
                                    width: 14, height: 14,),
                                  const SizedBox(width: 5,),
                                  const Text("记住密码", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 12.0))
                                  // RichText(text: const TextSpan(
                                  //   children: [
                                  //     TextSpan(
                                  //       text: "我已阅读并同意",
                                  //       style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14.0),
                                  //     ),
                                  //     TextSpan(
                                  //       text: "相关条款",
                                  //       style: TextStyle(color: Color(0xFF5D5FEF), fontSize: 14.0),
                                  //     ),
                                  //     TextSpan(
                                  //       text: "和",
                                  //       style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14.0),
                                  //     ),
                                  //     TextSpan(
                                  //       text: "隐私政策",
                                  //       style: TextStyle(color: Color(0xFF5D5FEF), fontSize: 14.0),
                                  //     )
                                  //   ],
                                  // )) ,
                                ],
                              ),
                              onTap: (){
                                controller.clickSavePasswordBtn();
                              },
                            );
                          }),
                          TextButton(onPressed: (){}, child: const Text("忘记密码?", style: TextStyle(color: Colors.white, fontSize: 12),))
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Obx(() {
                        return Container(
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: controller.canLogin.value ?
                            const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]):
                            const LinearGradient(colors: [Color(0xFF3D3891), Color(0xFF351D94)]),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50))
                            ),
                            onPressed: (){

                            }, child: Text("立即登录", style: TextStyle(fontSize: 14,
                              color: controller.canLogin.value ? Colors.white
                                  :const Color(0xFFB2B3BD))),),
                        );
                      }),
                      const SizedBox(height: 120,),
                      RichText(text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "已有账号？",
                            style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14.0),
                          ),
                          TextSpan(
                              text: "去注册",
                              style: const TextStyle(color: Colors.white, fontSize: 14.0),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                RouteUtil.pushToView(Routes.registerPage, offLast: true);
                              }
                          ),
                        ],
                      ))
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

