
import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String imageStr;
  final String hintText;
  ValueChanged<String>? valueChanged;
  Function? onTap;
  final TextInputType keybordType;
  Widget? rightWidget;
  final bool isObscureText;
  CustomInputField(this.imageStr, this.hintText, {this.valueChanged, this.onTap,this.rightWidget,this.isObscureText = false, this.keybordType = TextInputType.text, super.key,});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  FocusNode focusNode = FocusNode();
  bool isOnTap = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if((focusNode.hasFocus)) {
        setState(() {
          isOnTap = true;
        });
      }else {
        setState(() {
          isOnTap = false;
        });
      }
    });
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
            width: 60,
            child: Image.asset(widget.imageStr, width: 30, height: 30,),
          ),
          Expanded(child: TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              hintText: widget.hintText,
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none
              ),
              // borderSide: BorderSide.none
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            cursorColor: Colors.white,
            focusNode: focusNode,
            onChanged: (value) {
              if(widget.valueChanged != null) {
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



