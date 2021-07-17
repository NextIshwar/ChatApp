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
        backgroundColor: Colors.teal[900],
        title: Row(
          children: [
            Icon(
              Icons.account_circle,
              size: 30.0,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "$receiverName",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.video_call),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.call),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          MessageBody(
            chatId: chatId,
            senderName: senderName,
          ),
          Positioned(
            bottom: 0,
            child: WriteMessage(
              chatId: chatId,
              senderName: senderName,
              receiverName: receiverName,
            ),
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
          return (noOfData > 0)
              ? ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment:
                          data[index]['senderName'] == widget.senderName
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                                  data[index]['senderName'] == widget.senderName
                                      ? Colors.teal[900]
                                      : Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              data[index]['msg'],
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                  itemCount: noOfData,
                )
              : SizedBox();
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
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: msgController,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.attach_file),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                    )
                  ],
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
