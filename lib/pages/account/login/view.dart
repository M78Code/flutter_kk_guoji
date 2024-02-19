import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/generated/assets.dart';
import 'package:kkguoji/pages/account/login/logic.dart';
import 'package:kkguoji/pages/account/register/logic.dart';
import 'package:kkguoji/services/sqlite_service.dart';
import 'package:kkguoji/widget/keyboard_dismissable.dart';
import '../../../routes/routes.dart';
import '../../../utils/route_util.dart';
import '../../../widget/custom_input_field.dart';
import '../../main/logic/main_logic.dart';

class KKLoginPage extends StatefulWidget {
  const KKLoginPage({super.key});

  @override
  State<KKLoginPage> createState() => _KKLoginPageState();
}

class _KKLoginPageState extends State<KKLoginPage> {
  late LoginLogic controller = Get.find<LoginLogic>();
  final mainLogic = Get.find<MainPageLogic>();
  final sqlitService = Get.find<SqliteService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.lazyPut(() => LoginLogic());
    Get.lazyPut(() => RegisterLogic());


  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDissmissable(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(Assets.imagesRegisterBg),
                ),
              ),
              child: Container(
                decoration: const BoxDecoration(color: Color(0xED2E374C)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 48,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: TextButton(
                                onPressed: () {
                                  RouteUtil.popView();
                                },
                                child: Image.asset(
                                  Assets.imagesBackNormal,
                                  width: 40,
                                  height: 40,
                                )),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Image.asset(
                              Assets.myaccountAccountNewLogo,
                              width: 163,
                              height: 45,
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            CustomInputField(Assets.imagesAccountIcon, "请输入用户名",
                              valueChanged: (value) => controller.inputAccountValue(value),
                              text: controller.accountObs.value,
                              radius: 21,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              return CustomInputField(Assets.imagesPasswordIcon, "请输入密码",
                                  text: controller.passwordObs.value,
                                  isObscureText: controller.psdObscure.value,
                                  rightWidget: GestureDetector(
                                    child: SizedBox(
                                      width: 60,
                                      child: Image.asset(
                                        controller.psdObscure.value ? Assets.imagesPasswordOn : Assets.imagesPasswordOff,
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    onTap: () {
                                      controller.showPassword();
                                    },
                                  ),
                                  radius: 21,
                                  valueChanged: (value) => controller.inputPasswordValue(value));
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              return Offstage(
                                offstage: controller.isHiddenVerCode.value,
                                child: CustomInputField(Assets.imagesVerCode, "请输入验证码", valueChanged: (value) {
                                  controller.inputVerCodeValue(value);
                                },
                                    rightWidget: GestureDetector(
                                      child: SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child: controller.verCodeImageBytes.value.isEmpty
                                                ? Container()
                                                : Image.memory(
                                              Uint8List.fromList(controller.verCodeImageBytes.value),
                                              width: 80,
                                              height: 25,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      onTap: () {
                                        controller.getVerCode();
                                      },
                                    ),
                                  radius: 21,
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() {
                                  return GestureDetector(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          controller.savePassword.value ? Assets.imagesPrivacyBtnSelected : Assets.imagesPrivacyBtnNormal,
                                          width: 14,
                                          height: 14,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
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
                                    onTap: () {
                                      controller.clickSavePasswordBtn();
                                    },
                                  );
                                }),
                                TextButton(
                                    onPressed: () {
                                      // RouteUtil.pushToView(Routes.customer);
                                      Get.toNamed(Routes.customer);
                                    },
                                    child: const Text(
                                      "忘记密码?",
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  gradient: controller.canLogin.value
                                      ? const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)])
                                      : const LinearGradient(colors: [Color(0xFF3D3891), Color(0xFF351D94)]),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: TextButton(
                                  style: ButtonStyle(minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50))),
                                  onPressed: () {
                                    controller.clickLoginBtn();
                                  },
                                  child: Text("立即登录", style: TextStyle(fontSize: 14, color: controller.canLogin.value ? Colors.white : const Color(0xFFB2B3BD))),
                                ),
                              );
                            }),
                            // const SizedBox(height: 25,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Container(
                            //       height: 1.0,
                            //       width: 50,
                            //       color: Color.fromRGBO(255, 255, 255, 0.15),
                            //     ),
                            //     const SizedBox(width: 20,),
                            //     const Text("快速登录", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14),),
                            //     const SizedBox(width: 20,),
                            //     Container(
                            //       height: 1.0,
                            //       width: 50,
                            //       color: const Color.fromRGBO(255, 255, 255, 0.15),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 5,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     // TextButton(onPressed: (){}, child:Image.asset("assets/images/facebook.png", width: 40, height: 40,) ),
                            //     // TextButton(onPressed: (){}, child:Image.asset("assets/images/whatapp.png", width: 40, height: 40,) ),
                            //     // TextButton(onPressed: (){}, child:Image.asset("assets/images/gmail.png", width: 40, height: 40,) ),
                            //     TextButton(onPressed: (){
                            //       Get.find<RegisterLogic>().loginWithTg();
                            //     }, child:Image.asset("assets/images/telegram.png", width: 40, height: 40,) )
                            //
                            //   ],
                            // ),
                            const SizedBox(
                              height: 120,
                            ),
                            RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "没有账号？",
                                      style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14.0),
                                    ),
                                    TextSpan(
                                        text: "去注册",
                                        style: const TextStyle(color: Colors.white, fontSize: 14.0),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            RouteUtil.pushToView(Routes.registerPage, offLast: true);
                                          }),
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
      ),
    );
  }
}
