import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kkguoji/common/extension/index.dart';
import 'package:kkguoji/pages/activity/list/activity_model.dart';

///输入框
Widget inputTextEdit({
  TextEditingController? editController,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  String? preText,
  double hintTextSize = 20,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
  Function(String value)? callback,
}) {
  return Container(
    height: 44.h,
    width: double.infinity,
    alignment: Alignment.centerLeft,
    // margin: EdgeInsets.only(top: marginTop.h),
    decoration: BoxDecoration(
      // color: Colors.white
      border: Border(
        bottom: BorderSide(
          width: 1.h,
          color: Colors.white.withOpacity(0.06),
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(width: 5.w),
        Text(
          preText ?? "",
          style: const TextStyle(color: Colors.white),
        ),
        // SizedBox(width: 10.w),
        Expanded(
          child: TextField(
            autofocus: autofocus,
            controller: editController,
            keyboardType: keyboardType,
            onChanged: (value) => callback?.call(value),
            maxLength: 10,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              hintStyle: TextStyle(
                fontSize: hintTextSize.sp,
                color: Colors.white.withOpacity(0.2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

// const TextField({
// Key key,
// this.controller,//控制器 跟文本交互一般通过该属性
// this.focusNode,//焦点
// this.decoration = const InputDecoration(),//装饰 用来装饰外观
// TextInputType keyboardType,//键盘类型，即输入类型
// this.textInputAction,//键盘按钮
// this.textCapitalization = TextCapitalization.none,//大小写
// this.style,//样式
// this.strutStyle,
// this.textAlign = TextAlign.start,//对齐方式
// this.textDirection,
// this.autofocus = false,//自动聚焦
// this.obscureText = false,//是否隐藏文本，即显示密码类型
// this.autocorrect = true,//自动更正
// this.maxLines = 1,//最多行数，高度与行数同步
// this.minLines,//最小行数
// this.expands = false,
// this.maxLength,//最多输入数，有值后右下角就会有一个计数器
// this.maxLengthEnforced = true,
// this.onChanged,//输入改变回调
// this.onEditingComplete,//输入完成时，配合TextInputAction.done使用
// this.onSubmitted,//提交时,配合TextInputAction
// this.inputFormatters,//输入校验
// this.enabled,//是否可用
// this.cursorWidth = 2.0,//光标宽度
// this.cursorRadius,//光标圆角
// this.cursorColor,//光标颜色
// this.keyboardAppearance,
// this.scrollPadding = const EdgeInsets.all(20.0),
// this.dragStartBehavior = DragStartBehavior.start,
// this.enableInteractiveSelection,
// this.onTap,//点击事件
// this.buildCounter,
// this.scrollPhysics,
// })

Widget buttonSubmit({
  String text = "",
  Color textColor = Colors.white,
  double height = 44,
  required Function() onPressed,
}) {
  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF3D35C6), Color(0xFF6C4FE0)],
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        backgroundColor: Colors.transparent, //设置为透明，使用背景渐变色
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.white
            // color: controller.canLogin.value
            //     ? Colors.white
            //     : const Color(0xFFB2B3BD)),
            ),
      ),
    ),
  );
}

class CategoryRadioWidget extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final Function(CategoryModel category)? onTap;

  const CategoryRadioWidget({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39.h,
      width: 98.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color.fromRGBO(93, 66, 206, 0.5)
            : Colors.transparent,
        border: Border.all(
          width: 1,
          color: const Color(0xff4E5Ac5),
        ),
        borderRadius: BorderRadius.all(Radius.circular(30.r)),
      ),
      child: null == category.imgPath
          ? Text(
              category.name,
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(category.imgPath!, width: 12.w, height: 12.h),
                SizedBox(width: 5.w),
                Text(
                  category.name,
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ],
            ),
    ).onTap(() => onTap?.call(category));
  }
}
