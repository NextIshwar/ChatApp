import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String? tag, receiverName;
  const UserProfile({Key? key, required this.tag, this.receiverName})
      : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ScrollController controller = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
  String? title = "";
  Color? backgroundColor = Colors.transparent;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        if (controller.offset != 0.0) {
          backgroundColor = Colors.teal[900];
          title = widget.receiverName;
        } else {
          backgroundColor = Colors.transparent;
          title = "";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: (title == "") ? Colors.black : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title ?? "",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: (title == "") ? Colors.black : Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            ProfilePicture(
              height: height * 0.4,
              width: width,
              tag: widget.tag ?? "",
              userName: widget.receiverName,
            ),
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
  final String? userName;
  const ProfilePicture(
      {Key? key,
      required this.height,
      required this.width,
      required this.tag,
      this.userName})
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
                      userNameTag: userName ?? "",
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
            child: Hero(
              tag: userName ?? "",
              child: Text(
                userName ?? "",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
