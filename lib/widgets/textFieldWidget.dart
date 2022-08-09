import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final hint,obsecure,controller,validator;
  const TextFieldWidget({Key? key,required this.validator,required this.obsecure,required this.hint,required this.controller}) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20,left: 10,right: 10),
      child: TextFormField(
style: TextStyle(color: Colors.white),
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.obsecure,
        decoration: InputDecoration(
          hintText: widget.hint,

          hintStyle: TextStyle(color: Color(0xffFFEBC1)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          )
        ),
      ),
    );
  }
}
