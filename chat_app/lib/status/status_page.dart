import 'dart:async';

import 'package:chat_app/common/chat_imports.dart';
import 'package:chat_app/model/status_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class StatusPage extends StatefulWidget {
  final String? userId, userName;
  const StatusPage({Key? key, this.userId, this.userName}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<UserStatus> myStatus = [];
  Map<String, OtherStatus> statuses = {};
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Query(
        options: QueryOptions(document: gql(Queries.getTextStatus)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          const oneSec = const Duration(seconds: 20);
          new Timer.periodic(oneSec, (Timer t) => refetch);
          Status status = Status.fromJson(result.data ?? {});
          for (int i = 0; i < status.userStatus!.length; i++) {
            if (status.userStatus?[i].userId == widget.userId &&
                status.userStatus!
                        .where((element) => element.userId == widget.userId)
                        .length <=
                    myStatus.length) {
              myStatus.add(
                UserStatus(
                  userName: status.userStatus?[i].userName,
                  textMsg: status.userStatus?[i].textStatus,
                ),
              );
            } else {
              if (!statuses.containsKey(status.userStatus?[i].userId)) {
                statuses[status.userStatus?[i].userId ?? ""] = OtherStatus(
                    status.userStatus?[i].userName,
                    [status.userStatus?[i].textStatus ?? ""]);
              } else {
                statuses[status.userStatus?[i].userId]
                    ?.statuses!
                    .add(status.userStatus?[i].textStatus ?? "");
              }
              // status.add(
              //   UserStatus(
              //       userName: result.data?['User_status'][i]['userName'],
              //       textMsg: result.data?['User_status'][i]['textStatus']),
              // );
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
                      children: statuses.entries
                          .map(
                            (e) => ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(AllImages.defaultProfileImage),
                              ),
                              title: Text(
                                e.value.userName ?? "Default",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "18/06/2021",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyStatus(
                                      userId: e.value.userName,
                                      textMessage: e.value.statuses!
                                          .map(
                                            (n) => UserStatus(
                                              userName: e.value.userName,
                                              textMsg: n.toString(),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
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
  final String? timeStamp;
  UserStatus({this.userName, this.textMsg, this.timeStamp});
}

class OtherStatus {
  final String? userName;
  final List<String>? statuses;

  OtherStatus(this.userName, this.statuses);
}
