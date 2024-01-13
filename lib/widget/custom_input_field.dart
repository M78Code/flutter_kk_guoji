import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatefulWidget {
  final String? imageStr;
  final String hintText;
  ValueChanged<String>? valueChanged;
  Function? onTap;
  final TextInputType keybordType;
  Widget? rightWidget;
  final bool isObscureText;
  bool isWillShowSuccess;
  String text;
  bool? isOK;
  int maxLength;
  Color hintColor;
  final double radius;

  CustomInputField(
    this.imageStr,
    this.hintText, {
    this.hintColor = Colors.grey,
    this.valueChanged,
    this.onTap,
    this.rightWidget,
        this.isWillShowSuccess = false,
    this.text = "",
        this.isOK,
    this.isObscureText = false,
    this.keybordType = TextInputType.text,
    this.maxLength = 24,
    this.radius = 6,
    super.key,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  FocusNode focusNode = FocusNode();
  bool isOnTap = false;
  String inputText = "";
  TextEditingController? _textEditingController;
  Color borderColor = const Color(0x1AFFFFFF);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputText = widget.text;
    _textEditingController = TextEditingController.fromValue(TextEditingValue(text: inputText));
      focusNode.addListener(() {
        if ((focusNode.hasFocus)) {
          borderColor = const Color(0xFF5D5FEF);
        } else {
          borderColor = const Color(0x1AFFFFFF);
        }
        if(widget.isOK != null) {
          borderColor = widget.isOK! ? Colors.green:Colors.red;
          // setState(() {});
        }
        setState(() {});
      });

  }

  @override
  void didUpdateWidget(covariant CustomInputField oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    var cursorPos = _textEditingController!.selection;
    // 更新text值到_textController
    _textEditingController!.text = inputText ?? '';
    if (cursorPos.start > _textEditingController!.text.length) {
      // 光标保持在文本最后
      cursorPos =
          TextSelection.fromPosition(TextPosition(offset: _textEditingController!.text.length));
    }
    _textEditingController!.selection = cursorPos;
    if(widget.isOK != null) {
      borderColor = widget.isOK! ? Colors.green:Colors.red;
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x3D6C7A8F),
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        border: Border.all(
            color: borderColor, width: 1.0,
        )
      ),
      height: 42,
      child: Row(
        children: [
          if (null != widget.imageStr && widget.imageStr!.isNotEmpty)
            SizedBox(
              width: 40,
              child: Image.asset(
                widget.imageStr!,
                width: 25,
                height: 25,
              ),
            ),
          if (null == widget.imageStr || widget.imageStr!.isEmpty) SizedBox(width: 15.w),
          Expanded(
              child: TextField(
            controller: _textEditingController,
            keyboardType: widget.keybordType,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.all(0),
              hintText: widget.hintText,

              border: const OutlineInputBorder(borderSide: BorderSide.none),
              // borderSide: BorderSide.none
              hintStyle: TextStyle(color: widget.hintColor, fontSize: 13),
            ),
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.2,
            ),
            cursorColor: Colors.white,
            focusNode: focusNode,
            onChanged: (value) {
              if (widget.valueChanged != null) {
                inputText = value;
                widget.valueChanged!(value);
              }
            },
            obscureText: widget.isObscureText,
          )),
          Container(
            child: widget.rightWidget != null ? widget.rightWidget! : null,
          ),
          // widget.isWillShowSuccess ? Container(
          //   width: 30, height: 30,
          //   child: widget.isOK ? Image.asset(""):,
          // ):null,

        ],
      ),
    );
  }
}
