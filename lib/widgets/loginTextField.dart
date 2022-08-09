import 'package:flutter/material.dart';

class LoginTextFieldWidget extends StatefulWidget {
  final String hint;
  final IconData suffixIcon;
  final bool obsecure;
  final controller;
  const LoginTextFieldWidget(
      {Key? key,
      required this.controller,
      required this.obsecure,
      required this.hint,
      required this.suffixIcon})
      : super(key: key);

  @override
  _LoginTextFieldWidgetState createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .07, vertical: 10),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obsecure,
        decoration: InputDecoration(
            focusColor: Colors.white,
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hint,
            suffixIcon: Icon(widget.suffixIcon),
            // focusedBorder: OutlineInputBorder(
            //     borderSide: BorderSide(color: Colors.transparent),
            //     borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
