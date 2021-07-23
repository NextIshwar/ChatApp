import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';

class MediaFilesWidget extends StatelessWidget {
  const MediaFilesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Media, links and docs",
            style: TextStyle(
                color: ColorPalette.secondaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                50,
                (index) => Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    AllImages.defaultProfileImage,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
