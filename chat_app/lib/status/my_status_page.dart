import 'package:chat_app/status/status_page.dart';
import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';

class MyStatus extends StatefulWidget {
  final String? userId;
  final List<UserStatus>? textMessage;
  const MyStatus({Key? key, this.userId, this.textMessage}) : super(key: key);

  @override
  _MyStatusState createState() => _MyStatusState();
}

class _MyStatusState extends State<MyStatus> {
  static StoryController controller = StoryController();
  @override
  void initState() {
    super.initState();
    widget.textMessage?.forEach((element) {
      items.add(StoryItem.text(
          title: element.textMsg ?? "", backgroundColor: Colors.yellow));
    });
  }

  List<StoryItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Material(
        child: StoryView(
      onComplete: () {
        Navigator.pop(context);
      },
      storyItems: items,
      controller: controller,
      inline: false,
      repeat: true,
    ));
  }
}
