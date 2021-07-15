class Queries {
  static final Queries _Queries = Queries._();

  factory Queries() {
    return _Queries;
  }

  Queries._();

  static String getUsers = r'''subscription MyQuery($id: String!) {
  User_users_aggregate(where: {_not: {id: {_eq: $id}}}){
    nodes{
      name
      id
      email
    }
  }
}''';

  static String insertUser =
      r'''mutation insertUser($name:String!,$id:String!,$email:String!){
  insert_User_users(objects:[{name:$name,id:$id,email:$email}]){
    returning {
      name
      id
      email
    }
  }
}''';

  static String sendMsg =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_chat(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';

  static String getMsgs = r'''subscription MyQuery($id: String!) {
  channel_chat_aggregate(where: {channelId: {_eq: $id}}) {
    nodes {
      msg
      receiverName
      senderName
      timeStamp
    }
  }
}
''';
}
