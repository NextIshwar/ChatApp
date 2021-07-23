import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';

class OtherUserDetails extends StatefulWidget {
  final double height, width;
  const OtherUserDetails({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  _OtherUserDetailsState createState() => _OtherUserDetailsState();
}

class _OtherUserDetailsState extends State<OtherUserDetails> {
  bool notificationValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(color: ColorPalette.primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediaFilesWidget(),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black87,
            thickness: 15,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.width * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mute Notification",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.secondaryColor),
                ),
                Switch(
                    value: notificationValue,
                    activeColor: ColorPalette.switchColor,
                    onChanged: (val) {
                      setState(() {
                        notificationValue = val;
                      });
                    })
              ],
            ),
          ),
          Divider(
            color: Colors.black26,
          ),
          CutstomTextWdiget(text: "Custom notification"),
          Divider(
            color: Colors.black26,
          ),
          CutstomTextWdiget(text: "Starred messages"),
          Divider(
            color: Colors.black26,
          ),
          CutstomTextWdiget(text: "Media visibility"),
        ],
      ),
    );
  }
}
