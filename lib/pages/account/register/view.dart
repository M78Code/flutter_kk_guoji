import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kkguoji/common/extension/ex_widget.dart';
import 'package:kkguoji/pages/account/register/logic.dart';
import 'package:kkguoji/pages/account/register/segment_contrl_view.dart';
import 'package:kkguoji/utils/route_util.dart';
import 'package:kkguoji/widget/custom_input_field.dart';
import 'package:kkguoji/widget/show_toast.dart';

import '../../../generated/assets.dart';
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
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: [
          GestureDetector(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(Assets.myaccountAccountNewLogo, width: 163, height: 45,),
                            const SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Container(
                                  height:36,
                                  decoration: BoxDecoration(
                                    // color: const Color.fromRGBO(10, 11, 34, 0.12),
                                    gradient: const LinearGradient(colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)]) ,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: TextButton(onPressed: (){
                                  }, child: const Text("用户名注册", style: TextStyle(fontSize: 14, color: Colors.white )),),
                                ))
                              ],
                            ),
                            // Obx(() {
                            //   return SegmentControlView((value) {
                            //     FocusScope.of(context).requestFocus(FocusNode());
                            //     controller.setRegisterType(value);
                            //   }, controller.isAccount.value);
                            // }),
                            const SizedBox(height: 30,),
                            Obx(() {
                              return CustomInputField("assets/images/account_icon.png", controller.isAccount.value?"请输入用户名":"请输入电子邮箱", valueChanged: (value){
                                controller.inputAccountValue(value);
                              },text: controller.accountText, 
                                isOK: controller.accountOK.value,
                                radius: 21, 
                                showStateIcon: controller.accountOK.value == null? false:true,
                              inputCompletionCallBack: (value, isSubmit) => controller.inputAccountValue(value),);

                            }),
                            const SizedBox(height: 8,),
                            Obx(() {
                              return Offstage(
                                offstage: controller.accountErrStr.value.isEmpty,
                                child: _buildErrHit(controller.accountErrStr.value)

                              );
                            }),
                            const SizedBox(height: 8,),
                            Obx(() {
                              return CustomInputField("assets/images/password_icon.png", "请输入8-12位字母+数字+字符密码",
                                isObscureText: controller.psdObscure.value, rightWidget: GestureDetector(
                                  child: SizedBox(width: 40,
                                    child: Image.asset(controller.psdObscure.value ? "assets/images/password_on.png":"assets/images/password_off.png", width: 25, height: 25,),),
                                  onTap: () {
                                    controller.showPassword();
                                  },
                                ), valueChanged: (value){
                                  controller.inputPasswordValue(value);
                                }, text: controller.passwordText, isOK: controller.psdOK.value,
                                showStateIcon: controller.psdOK.value == null? false:true,
                                inputCompletionCallBack: (value, isSubmit) => controller.passwordLastInput(value),
                              radius: 21,);
                            }),
                            const SizedBox(height: 8,),
                            Obx(() {
                              return Offstage(
                                  offstage: controller.passwordErrStr.value.isEmpty,
                                  child: Obx((){
                                    return _buildErrHit(controller.passwordErrStr.value);
                                  })

                              );
                            }),
                            Obx(() {
                              return Offstage(
                                  offstage: controller.isHiddenPsdHit.value,
                                  child: Row(
                                    children: [
                                      Obx((){
                                        return _buildHit(controller.psdLength.value, "长度8-12位");
                                      }),
                                      const SizedBox(width: 8,),
                                      Obx(() {
                                        return _buildHit(controller.psdLetter.value, "字母");
                                      }),
                                      const SizedBox(width: 8,),
                                      Obx((){
                                        return _buildHit(controller.psdNum.value, "数字");
                                      }),
                                      const SizedBox(width: 8,),

                                      Obx((){
                                        return _buildHit(controller.psdSys.value, "特殊符号");
                                      }),
                                    ],
                                  )

                              );
                            }),
                            const SizedBox(height: 8,),
                            Obx(() {
                              return CustomInputField(
                                "assets/images/password_icon.png",
                                "请再次输入8-12位字母+数字+字符密码",
                                isObscureText: controller.verPsdObscure.value,
                                radius: 21,
                                rightWidget: GestureDetector(
                                  child: SizedBox(width: 40,
                                    child: Image.asset(controller.verPsdObscure.value ? "assets/images/password_on.png":"assets/images/password_off.png", width: 25, height: 25,),),
                                  onTap: () {
                                    controller.showVerPassword();
                                  },
                                ), valueChanged: (value){
                                controller.inputVerPasswordValue(value);
                              },text: controller.verPsdText,
                                isOK: controller.verPsdOK.value,
                                inputCompletionCallBack: (value, isSubmit) => controller.verPasswordLastInput(value),
                                showStateIcon: controller.verPsdOK.value == null? false:true,);
                            }),
                            const SizedBox(height: 8,),
                            Obx(() {
                              return Offstage(
                                  offstage: controller.verPsdErrStr.value.isEmpty,
                                  child: Obx((){
                                    return _buildErrHit(controller.verPsdErrStr.value);
                                  })

                              );
                            }),

                            Obx(() {
                              return Offstage(
                                offstage: controller.isShowInvite.value,
                                child:  Column(
                                  children: [
                                    const SizedBox(height: 8,),
                                    CustomInputField(
                                      "assets/images/invite_icon.png",
                                      "请输入邀请码（选填）",
                                      radius: 21,
                                      valueChanged: (value){
                                        controller.inputInviteCodeValue(value);
                                      },),
                                  ],
                                )

                              );
                            }),
                            const SizedBox(height: 8,),
                            Obx(() {
                              return Offstage(
                                offstage: controller.isHiddenVerCode.value,
                                child: Obx((){
                                  return CustomInputField(
                                      "assets/images/ver_code.png",
                                      "请输入验证码",
                                      radius: 21,
                                      valueChanged: (value){
                                        controller.inputVerCodeValue(value);
                                      },
                                      inputCompletionCallBack: (value, isSubmit) => controller.inputVerCodeValue(value),
                                      text: controller.verCodeText,
                                      isOK: controller.verCodeOK.value,
                                      rightWidget: controller.isAccount.value ? GestureDetector(child: SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child:controller.verCodeImageBytes.value.isEmpty?
                                            Container(): Image.memory(Uint8List.fromList(controller.verCodeImageBytes.value), width: 80,
                                              height: 25, fit: BoxFit.cover,),
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
                              );
                            }),
                            const SizedBox(height: 8,),
                            Obx(() {
                              return Offstage(
                                  offstage: controller.verCodeErrStr.value.isEmpty,
                                  child: Obx((){
                                    return _buildErrHit(controller.verCodeErrStr.value);
                                  })

                              );
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
                                              Get.toNamed(Routes.privacyPage, arguments: ["服务条款", "assets/html/register_protocol.html"]);

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
                                              Get.toNamed(Routes.privacyPage, arguments: ["隐私政策", "assets/html/privacy.html"]);
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
                                // TextButton(onPressed: (){}, child:Image.asset("assets/images/facebook.png", width: 40, height: 40,) ),
                                // TextButton(onPressed: (){}, child:Image.asset("assets/images/whatapp.png", width: 40, height: 40,) ),
                                // TextButton(onPressed: (){}, child:Image.asset("assets/images/gmail.png", width: 40, height: 40,) ),
                                TextButton(onPressed: (){
                                  controller.loginWithTg();
                                }, child:Image.asset("assets/images/telegram.png", width: 40, height: 40,) )

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
          ),
          // Positioned(
          //   bottom: 30.w,
          //   right: 20.w,
          //   child: SizedBox(width: 46.w, height: 46.w, child: Image.asset(Assets.gamesSupport)).onTap(() {
          //     // RouteUtil.pushToView(Routes.customer);
          //     Get.toNamed(Routes.customer);
          //   }),
          // ),
        ],
      )
    );
  }

  Widget _buildHit(bool isOK, String title) {

    return Row(
      children: [
        Container(width: 5, height: 5, decoration: BoxDecoration(
          color: isOK? const Color(0xFF20F752):const Color(0xFF6C7187),
          borderRadius: BorderRadius.circular(2.5),
        ),),
        const SizedBox(width: 3,),
        Text(title, style: TextStyle(color:isOK? const Color(0xFF20F752):const Color(0xFF6C7187), fontSize: 14, fontWeight: FontWeight.w600 ),),
        const SizedBox(width: 5,),
        Image.asset(isOK ? Assets.accountHitOk:Assets.accountHitNormal, width: 16, height: 16,)
      ],
    );
  }

  Widget _buildErrHit(String title) {

    return Row(
      children: [
        Container(width: 5, height: 5, decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(2.5),
        ),),
        const SizedBox(width: 3,),
        Text(title, style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w600 ),),
        const SizedBox(width: 5,),
        Image.asset(Assets.accountHitErr, width: 16, height: 16,)
      ],
    );
  }

}

