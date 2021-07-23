import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';

class CutstomTextWdiget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const CutstomTextWdiget({Key? key, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.02, horizontal: width * 0.025),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: ColorPalette.secondaryColor),
        ),
      ),
    );
  }
}
