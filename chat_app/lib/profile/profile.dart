import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String tag;
  const UserProfile({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePicture(height: height * 0.4, width: width, tag: tag),
            OtherUserDetails(
              height: height,
              width: width,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final double height, width;
  final Object tag;
  const ProfilePicture(
      {Key? key, required this.height, required this.width, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Hero(
            tag: tag,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewProfileImage(
                      tag: tag.toString(),
                    ),
                  ),
                );
              },
              child: Image.asset(
                AllImages.defaultProfileImage,
                height: height,
              ),
            ),
          ),
          Positioned(
            left: width * 0.01,
            bottom: height * 0.15,
            child: Text(
              "User Name",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

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
      child: Padding(
        padding: EdgeInsets.all(widget.width * 0.025),
        child: Column(
          children: [
            MediaFilesWidget(),
            SizedBox(
              height: widget.height * 0.01,
            ),
            Row(
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
            Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class MediaFilesWidget extends StatelessWidget {
  const MediaFilesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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

class ViewProfileImage extends StatelessWidget {
  final String tag;
  const ViewProfileImage({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("User Name"),
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
          child: Image.asset(AllImages.defaultProfileImage),
        ),
      ),
    );
  }
}
