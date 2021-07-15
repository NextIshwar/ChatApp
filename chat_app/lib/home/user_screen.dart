import 'package:chat_app/common/chat_imports.dart';
import 'package:chat_app/common/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserScreen extends StatelessWidget {
  final List<String>? token;
  UserScreen({this.token});
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.green.withOpacity(0.5),
          title: Center(
            child: Text(
              "${token?[userInfo.userName.index] ?? "User".toUpperCase()}'S CHATBOT",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        body: Subscription(
          options: SubscriptionOptions(
            variables: {"id": token?[userInfo.email.index]},
            document: gql(Queries.getUsers),
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              height: height,
              width: width,
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageScreen(
                            receiverId: result.data?['User_users_aggregate']
                                ['nodes'][index]['id'],
                            receiverName: result.data?['User_users_aggregate']
                                ['nodes'][index]['name'],
                            chatId: getChannelId(
                              token?[userInfo.email.index] ?? "",
                              result.data?['User_users_aggregate']['nodes']
                                  [index]['email'],
                            ),
                            senderName: token?[userInfo.userName.index] ?? "",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        result.data?['User_users_aggregate']['nodes'][index]
                            ['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                itemCount: result.data?['User_users_aggregate']['nodes'].length,
              ),
            );
          },
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
