import 'package:chat_app/common/graphql_config.dart';
import 'package:chat_app/common/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MessageScreen extends StatelessWidget {
  final String receiverId, receiverName, chatId, senderName;
  MessageScreen(
      {this.receiverId = "",
      this.receiverName = "",
      this.chatId = "",
      this.senderName = ""});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Center(
          child: Text(
            "$receiverName",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageBody(
              chatId: chatId,
              senderName: senderName,
            ),
            flex: 10,
          ),
          Expanded(
            child: WriteMessage(
              chatId: chatId,
              senderName: senderName,
              receiverName: receiverName,
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

class MessageBody extends StatefulWidget {
  final String chatId, senderName;
  MessageBody({this.chatId = "", this.senderName = ""});
  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Subscription(
        options: SubscriptionOptions(
          variables: {"id": "${widget.chatId}"},
          document: gql(Queries.getMsgs),
        ),
        builder: (result) {
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = result.data?['channel_chat_aggregate']['nodes'];
          var noOfData = data.length;
          return Container(
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
            ),
            child: (noOfData > 0)
                ? ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment:
                            (data[index]['senderName'] == widget.senderName)
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              data[index]['senderName'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data[index]['msg'])
                          ],
                        ),
                      ),
                    ),
                    itemCount: noOfData,
                  )
                : SizedBox(),
          );
        },
      ),
    );
  }
}

class WriteMessage extends StatefulWidget {
  final String chatId, senderName, receiverName;
  WriteMessage(
      {this.chatId = "", this.receiverName = "", this.senderName = ""});
  @override
  _WriteMessageState createState() => _WriteMessageState();
}

class _WriteMessageState extends State<WriteMessage> {
  TextEditingController msgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Mutation(
        options: MutationOptions(document: gql(Queries.sendMsg)),
        builder: (runMutation, result) => Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: msgController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    runMutation(<String, dynamic>{
                      "channelId": widget.chatId,
                      "senderName": widget.senderName,
                      "receiverName": widget.receiverName,
                      "msg": msgController.text
                    });
                    msgController.clear();
                  },
                  icon: Icon(Icons.send),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
