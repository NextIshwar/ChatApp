import 'package:chat_app/common/chat_imports.dart';
import 'package:chat_app/common/queries.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserScreen extends StatefulWidget {
  final List<String>? token;
  UserScreen({
    this.token,
  });

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4, initialIndex: 1);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: new AppBar(
          leading: Text(""),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                child: Text("CHATS"),
              ),
              Tab(
                child: Text(
                  "STATUS",
                ),
              ),
              Tab(
                child: Text(
                  "CALLS",
                ),
              ),
            ],
            indicatorColor: Colors.white,
          ),
          title: new Text(
            "ChatBot",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.search),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  _showPopupMenu(
                    context,
                    widget.token?[userInfo.userName.index] ?? "",
                    widget.token?[userInfo.email.index],
                  );
                },
              ),
            ),
          ],
          backgroundColor: Colors.teal[900],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            Icon(Icons.camera_alt),
            Subscription(
              options: SubscriptionOptions(
                variables: {"id": widget.token?[userInfo.email.index]},
                document: gql(Queries.getUsers),
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                UserData userData = UserData.fromJson(result.data ?? {});
                return Container(
                  height: height,
                  width: width,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var data = userData.userUsersAggregate!.nodes?[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      data!.profileImage ??
                                          AllImages.avatarImage),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MessageScreen(
                                            receiverId: data.id ?? "",
                                            receiverName: data.name ?? "",
                                            chatId: getChannelId(
                                              widget.token?[
                                                      userInfo.email.index] ??
                                                  "",
                                              data.email,
                                            ),
                                            senderName: widget.token?[
                                                    userInfo.userName.index] ??
                                                "",
                                            imageUrl: data.profileImage ??
                                                AllImages.avatarImage,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                data.name ?? "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20.0),
                                              ),
                                              Text(
                                                "18/06/2021",
                                                style: TextStyle(
                                                    color: Colors.black45),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: Text(
                                              "Hi There",
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                    itemCount: userData.userUsersAggregate!.nodes!.length,
                  ),
                );
              },
            ),
            StatusPage(
              userId: widget.token?[userInfo.email.index],
              userName: widget.token?[userInfo.userName.index],
            ),
            Text("Call Screen"),
          ],
        ),
      ),
    );
  }
}

String getChannelId(String sender, receiver) {
  String concat = sender + receiver;
  var valList = concat.split("");
  valList.sort();
  return valList.toString();
}

void _showPopupMenu(BuildContext context, String userName, email) async {
  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(1000, 90, 40, 10),
    items: [
      PopupMenuItem<String>(
          child: InkWell(
            child: const Text(
              'My Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProfile(
                    userName: userName,
                    email: email,
                  ),
                ),
              );
            },
          ),
          value: 'profile'),
      PopupMenuItem<String>(
          child: InkWell(
            child: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              SharedPreference.logout(context);
            },
          ),
          value: 'logout'),
    ],
    elevation: 8.0,
  );
}
