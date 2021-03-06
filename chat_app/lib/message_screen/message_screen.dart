import 'dart:math';

import 'package:chat_app/common/chat_imports.dart';
import 'package:chat_app/common/graphql_config.dart';
import 'package:chat_app/common/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MessageScreen extends StatelessWidget {
  final String receiverId, receiverName, chatId, senderName, imageUrl;
  MessageScreen({
    this.receiverId = "",
    this.receiverName = "",
    this.chatId = "",
    this.senderName = "",
    this.imageUrl = "",
  });
  @override
  Widget build(BuildContext context) {
    final modedValue = (senderName + receiverName).length % 10;
    final String getMsgQuery = Queries.findGetMsgQuery(modedValue);
    final String tableName = Queries.getTableName(modedValue);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfile(
                  tag: receiverId,
                  receiverName: receiverName,
                  imageUrl: imageUrl,
                ),
              ),
            );
          },
          child: Row(
            children: [
              Hero(
                tag: receiverId,
                child: (imageUrl != "")
                    ? CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          imageUrl,
                        ))
                    : Icon(
                        Icons.account_circle,
                        size: 30.0,
                      ),
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
            receiverName: receiverName,
            queryString: getMsgQuery,
            tableName: tableName,
          ),
          Positioned(
            bottom: 20,
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
  final String chatId, senderName, receiverName, queryString, tableName;
  MessageBody({
    this.chatId = "",
    this.senderName = "",
    this.receiverName = "",
    this.queryString = "",
    this.tableName = "",
  });
  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Subscription(
        options: SubscriptionOptions(
          variables: {"id": "${widget.chatId}"},
          document: gql(widget.queryString),
        ),
        builder: (result) {
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var data = result.data?[widget.tableName];
          if (data?.length <= 0) {
            return Center(
              child: Text("Please enter your first message"),
            );
          }
          var noOfData = data?.length;
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
                          constraints: BoxConstraints(maxWidth: width * 0.5),
                          decoration: BoxDecoration(
                            color:
                                data[index]['senderName'] == widget.senderName
                                    ? Colors.teal[900]
                                    : Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: (data[index]['isUrl'] ?? false)
                              ? Container(
                                  height: 150,
                                  width: 150,
                                  child: Image.network(data[index]['msg']),
                                )
                              : Text(
                                  data[index]['msg'],
                                  style: TextStyle(color: Colors.white),
                                ),
                        )
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
  late TextEditingController msgController;
  String attachedImageUrl = "";
  @override
  void initState() {
    super.initState();
    msgController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    msgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modValue =
        (widget.receiverName.length + widget.senderName.length) % 10;
    final String createMsgQuery = Queries.findCreateMsgQuery(modValue);
    return GraphQLProvider(
      client: Config.initailizeClient(),
      child: Mutation(
        options: MutationOptions(
          document: gql(createMsgQuery),
        ),
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
                          suffixIcon: (attachedImageUrl != "")
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 80.0, top: 10, bottom: 10),
                                  child: Image.network(
                                    attachedImageUrl,
                                    height: 200,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : null,
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
                            onPressed: () async {
                              var rng = new Random();
                              attachedImageUrl = await uploadImage(
                                  rng.nextInt(100000).toString());
                            },
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
                      "msg": (attachedImageUrl != "")
                          ? attachedImageUrl
                          : msgController.text,
                      "isUrl": attachedImageUrl != "",
                    });
                    msgController.clear();
                    attachedImageUrl = "";
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
