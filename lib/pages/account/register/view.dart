import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkguoji/pages/account/register/logic.dart';
import 'package:kkguoji/pages/account/register/segment_contrl_view.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/widget/custom_input_field.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../../../routes/routes.dart';


class KKRegisterPage extends StatefulWidget {
  const KKRegisterPage({super.key});

  @override
  State<KKRegisterPage> createState() => _KKRegisterPageState();
}

class _KKRegisterPageState extends State<KKRegisterPage> {

  late RegisterLogic controller = Get.find<RegisterLogic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.lazyPut(() => RegisterLogic());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
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
                          RouteUtil.popView();
                        }, child: Image.asset("assets/images/back_normal.png", width: 40, height: 40,)),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Image.asset("assets/images/regist_top_logo.png", width: 163, height: 45,),
                        const SizedBox(height: 30,),
                        Obx(() {
                          return SegmentControlView((value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            controller.setRegisterType(value);
                          }, controller.isAccount.value);
                        }),
                        const SizedBox(height: 30,),
                        Obx(() {
                          return CustomInputField("assets/images/account_icon.png", controller.isAccount.value?"请输入8-12位字母+数字用户名":"请输入电子邮箱", valueChanged: (value){
                            controller.inputAccountValue(value);
                          },);

                        }),
                        const SizedBox(height: 20,),
                        Obx(() {
                          return CustomInputField("assets/images/password_icon.png", "请输入8-12位字母+数字+字符密码",
                            isObscureText: controller.psdObscure.value, rightWidget: GestureDetector(
                              child: SizedBox(width: 40,
                                child: Image.asset(controller.psdObscure.value ? "assets/images/password_off.png":"assets/images/password_on.png", width: 25, height: 25,),),
                              onTap: () {
                                controller.showPassword();
                              },
                            ), valueChanged: (value){
                              controller.inputPasswordValue(value);
                            },);
                        }),
                        const SizedBox(height: 20,),
                        Obx(() {
                          return CustomInputField(
                            "assets/images/password_icon.png",
                            "请再次输入8-12位字母+数字+字符密码",
                            isObscureText: controller.verPsdObscure.value,
                            rightWidget: GestureDetector(
                              child: SizedBox(width: 40,
                                child: Image.asset(controller.verPsdObscure.value ? "assets/images/password_off.png":"assets/images/password_on.png", width: 25, height: 25,),),
                              onTap: () {
                                controller.showVerPassword();
                              },


                            ), valueChanged: (value){
                              controller.inputVerPasswordValue(value);
                            },);
                        }),
                        const SizedBox(height: 20,),
                        CustomInputField(
                          "assets/images/invite_icon.png",
                          "请输入邀请码（选填）",
                          valueChanged: (value){
                          controller.inputInviteCodeValue(value);
                        },),
                        const SizedBox(height: 20,),
                        Obx(() {
                          return CustomInputField(
                              "assets/images/ver_code.png",
                              "请输入验证码",
                              valueChanged: (value){
                                controller.inputVerCodeValue(value);
                          },
                              rightWidget: controller.isAccount.value ? GestureDetector(child: SizedBox(
                                width: 80,
                                child: Center(
                                  child:controller.verCodeImageBytes.value.isEmpty? Container(): Image.memory(Uint8List.fromList(controller.verCodeImageBytes.value), width: 60,),
                                )
                            ), onTap: () {controller.getVerCode();},
                          ):GestureDetector(
                            child: const SizedBox(
                                width: 110,
                                child: Center(
                                  child: Text("发送验证码", style: TextStyle(color: Colors.white, fontSize: 15),),
                                )
                            ), onTap: () {
                            controller.sendCodeToEmail();
                          },
                          ));
                        }),
                        const SizedBox(height: 25,),
                        Obx(() {
                          return GestureDetector(
                            child: Row(
                              children: [
                                Image.asset( controller.isAgree.value ?
                                "assets/images/privacy_btn_selected.png":
                                "assets/images/privacy_btn_normal.png",
                                  width: 14, height: 14,),
                                const SizedBox(width: 5,),
                                RichText(text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "我已阅读并同意",
                                      style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14.0),
                                    ),
                                    TextSpan(
                                        text: "相关条款",
                                        style: const TextStyle(color: Color(0xFF5D5FEF), fontSize: 14.0),
                                        recognizer: TapGestureRecognizer()..onTap = (){

                                        }
                                    ),
                                    const TextSpan(
                                      text: "和",
                                      style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14.0),
                                    ),
                                    TextSpan(
                                        text: "隐私政策",
                                        style: const TextStyle(color: Color(0xFF5D5FEF), fontSize: 14.0),
                                        recognizer: TapGestureRecognizer()..onTap = (){

                                        }
                                    )
                                  ],
                                )) ,
                              ],
                            ),
                            onTap: (){
                              controller.clickAgreeBtn();
                            },
                          );
                        }),
                        const SizedBox(height: 25,),
                        Obx(() {
                          return Container(
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: controller.isCanRegister.value ?
                              const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]):
                              const LinearGradient(colors: [Color(0xFF3D3891), Color(0xFF351D94)]),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50))
                              ),
                              onPressed: (){
                                controller.clickRegisterBtn();
                              }, child: Text("立即注册", style: TextStyle(fontSize: 14,
                                color: controller.isCanRegister.value ? Colors.white
                                    :const Color(0xFFB2B3BD))),),
                          );
                        }),
                        const SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1.0,
                              width: 50,
                              color: Color.fromRGBO(255, 255, 255, 0.15),
                            ),
                            const SizedBox(width: 20,),
                            const Text("快速登录", style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14),),
                            const SizedBox(width: 20,),
                            Container(
                              height: 1.0,
                              width: 50,
                              color: const Color.fromRGBO(255, 255, 255, 0.15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(onPressed: (){}, child:Image.asset("assets/images/facebook.png", width: 40, height: 40,) ),
                            TextButton(onPressed: (){}, child:Image.asset("assets/images/whatapp.png", width: 40, height: 40,) ),
                            TextButton(onPressed: (){}, child:Image.asset("assets/images/gmail.png", width: 40, height: 40,) ),
                            TextButton(onPressed: (){}, child:Image.asset("assets/images/telegram.png", width: 40, height: 40,) )

                          ],
                        ),
                        const SizedBox(height: 35,),
                        RichText(text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "已有账号？",
                              style: TextStyle(color: Color(0xFFB2B3BD), fontSize: 14.0),
                            ),
                            TextSpan(
                                text: "去登录",
                                style: const TextStyle(color: Colors.white, fontSize: 14.0),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  RouteUtil.pushToView(Routes.loginPage, offLast: true);
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
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      )
    );
  }
}

