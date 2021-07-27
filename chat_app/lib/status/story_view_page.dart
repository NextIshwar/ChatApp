import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';

class StoryViewPage extends StatefulWidget {
  final String? userId;
  const StoryViewPage({Key? key, this.userId}) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  static StoryController controller = StoryController();
  final List<StoryItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Subscription(
        options: SubscriptionOptions(
            document: gql(Queries.getTextStatus),
            variables: {"id": widget.userId}),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            result.data?['User_users_aggregate']['nodes'].forEach((element) {
              items.add(
                StoryItem.text(
                  title: element['textStatus'],
                  backgroundColor: Colors.yellow,
                ),
              );
            });
          }
          items.forEach((element) {});
          return StoryView(
            storyItems: items,
            controller: controller,
            inline: false,
            repeat: true,
          );
        },
      ),
    );
  }
}
