
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String imageStr;
  final String hintText;
  ValueChanged<String>? valueChanged;
  Function? onTap;
  final TextInputType keybordType;
  Widget? rightWidget;
  final bool isObscureText;
  String text;
  CustomInputField(this.imageStr, this.hintText, {this.valueChanged, this.onTap,this.rightWidget,this.text = "",this.isObscureText = false, this.keybordType = TextInputType.text, super.key,});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  FocusNode focusNode = FocusNode();
  bool isOnTap = false;
  String inputText = "";
  TextEditingController? _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputText = widget.text;
    _textEditingController = TextEditingController.fromValue(TextEditingValue(text: inputText));
    setState(() {


    });
    focusNode.addListener(() {
      if((focusNode.hasFocus)) {
          isOnTap = true;
      }else {
        isOnTap = false;
      }
      setState(() {


      });
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
      cursorPos = TextSelection.fromPosition(
          TextPosition(offset: _textEditingController!.text.length));
    }
    _textEditingController!.selection = cursorPos;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0x3D6C7A8F),
          borderRadius: const BorderRadius.all(Radius.circular(21)),
          border: Border.all(color: isOnTap?const Color(0xFF5D5FEF): const Color(0x1AFFFFFF), width: 1.0)
      ),
      height: 42,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Image.asset(widget.imageStr, width: 25, height: 25,),
          ),
          Expanded(child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              hintText: widget.hintText,
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none
              ),
              // borderSide: BorderSide.none
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            cursorColor: Colors.white,
            focusNode: focusNode,
            onChanged: (value) {
              if(widget.valueChanged != null) {
                inputText = value;
                widget.valueChanged!(value);
              }
            },
            obscureText: widget.isObscureText,

          )),
          Container(
            child: widget.rightWidget != null ? widget.rightWidget!: null,
          )
        ],
      ),
    );
  }
}



