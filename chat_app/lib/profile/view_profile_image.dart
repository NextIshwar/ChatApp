import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';

class ViewProfileImage extends StatelessWidget {
  final String tag;
  final String userNameTag, imageUrl;
  const ViewProfileImage(
      {Key? key,
      required this.tag,
      required this.userNameTag,
      this.imageUrl = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Hero(
          tag: userNameTag,
          child: Material(
            color: Colors.transparent,
            child: Text(
              "$userNameTag",
              style: TextStyle(
                  color: ColorPalette.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorPalette.secondaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: tag,
          child: (imageUrl != "")
              ? Image.network(
                  imageUrl,
                )
              : Image.asset(AllImages.defaultProfileImage),
        ),
      ),
    );
  }
}
