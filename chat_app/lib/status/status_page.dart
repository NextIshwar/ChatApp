import 'package:chat_app/common/chat_imports.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class StatusViewPage extends StatefulWidget {
  final String? userId, userName;
  const StatusViewPage({Key? key, this.userId, this.userName})
      : super(key: key);

  @override
  _StatusViewPageState createState() => _StatusViewPageState();
}

class _StatusViewPageState extends State<StatusViewPage> {
  List<UserStatus> status = [];
  List<UserStatus> myStatus = [];
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Query(
        options: QueryOptions(document: gql(Queries.getTextStatus)),
        builder: (result, {refetch, fetchMore}) {
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          for (int i = 0; i < result.data?['User_status'].length; i++) {
            if (result.data?['User_status'][i]['userId'] == widget.userId) {
              myStatus.add(
                UserStatus(
                    userName: result.data?['User_status'][i]['userName'],
                    textMsg: result.data?['User_status'][i]['textStatus']),
              );
            } else {
              status.add(
                UserStatus(
                    userName: result.data?['User_status'][i]['userName'],
                    textMsg: result.data?['User_status'][i]['textStatus']),
              );
            }
          }
          return Scaffold(
            backgroundColor: Color(0xfff2f2f2),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: ColorPalette.primaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Material(
                            child: AddStatus(
                          id: widget.userId,
                          userName: widget.userName,
                        )),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: ColorPalette.secondaryColor,
                  elevation: 0.0,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            //backgroundImage: NetworkImage(AllImages.avatarImage),
                          ),
                          Positioned(
                            child: Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: 25,
                              child: Icon(
                                Icons.add,
                                color: ColorPalette.secondaryColor,
                              ),
                              decoration: BoxDecoration(
                                color: ColorPalette.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            bottom: 0.0,
                            right: 1.0,
                          )
                        ],
                      ),
                      title: Text(
                        "My status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "tap to update status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyStatus(
                              userId: widget.userId,
                              textMessage: myStatus,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "View updates",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(color: ColorPalette.secondaryColor),
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      children: List.generate(
                        status.length,
                        (index) => ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(AllImages.defaultProfileImage),
                          ),
                          title: Text(
                            status[index].userName ?? "Default",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            status[index].textMsg ?? "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoryViewPage(
                                  userId: widget.userId,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // Subscription(
                //   options: SubscriptionOptions(
                //       document: gql(Queries.getTextStatus),
                //       variables: {"id": widget.userId}),
                //   builder: (result, {fetchMore, refetch}) {
                //     if (result.isLoading) {
                //       return Expanded(
                //         child: Container(
                //           decoration:
                //               BoxDecoration(color: ColorPalette.secondaryColor),
                //         ),
                //       );
                //     }
                //     return Expanded(
                //         child: Container(
                //       decoration:
                //           BoxDecoration(color: ColorPalette.secondaryColor),
                //       padding: EdgeInsets.all(8.0),
                //       child: ListView(
                //         children: List.generate(
                //           result.data?['User_status_aggregate']['nodes'].length,
                //           (index) => ListTile(
                //             leading: CircleAvatar(
                //               radius: 30,
                //               backgroundImage:
                //                   NetworkImage(AllImages.defaultProfileImage),
                //             ),
                //             title: Text(
                //               result.data?['User_status_aggregate']['nodes']
                //                   [index]['userName'],
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //             subtitle: Text(
                //               result.data?['User_status_aggregate']['nodes']
                //                   [index]['timeStamp'],
                //               style: TextStyle(fontWeight: FontWeight.bold),
                //             ),
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                   builder: (context) => StoryViewPage(
                //                     userId: widget.userId,
                //                   ),
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //     ));
                //   },
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}

class UserStatus {
  final String? userName;
  final String? textMsg;

  UserStatus({this.userName, this.textMsg});
}
