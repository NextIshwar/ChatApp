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

  static String sendMsgOnTable1 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table1(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';

  static String sendMsgOnTable2 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table2(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';
  static String sendMsgOnTable3 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table3(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';
  static String sendMsgOnTable4 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table4(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';
  static String sendMsgOnTable5 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table5(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';
  static String sendMsgOnTable6 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table6(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';
  static String sendMsgOnTable7 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table7(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';
  static String sendMsgOnTable8 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table8(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';
  static String sendMsgOnTable9 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table9(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';
  static String sendMsgOnTable10 =
      r'''mutation sendmsg($channelId:String!,$senderName:String!,$receiverName:String!, $msg:String!){
  insert_channel_table10(objects:[{channelId:$channelId,senderName:$senderName,receiverName:$receiverName,msg:$msg}]){
    returning{
      id
      msg
      timeStamp
      senderName
      receiverName
    }
  }
}''';

  static String getMsgsFromTable1 = r'''subscription MyQuery($id: String!) {
  channel_table1(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable2 = r'''subscription MyQuery($id: String!) {
  channel_table2(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable3 = r'''subscription MyQuery($id: String!) {
  channel_table3(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable4 = r'''subscription MyQuery($id: String!) {
  channel_table4(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable5 = r'''subscription MyQuery($id: String!) {
  channel_table5(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable6 = r'''subscription MyQuery($id: String!) {
  channel_table6(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable7 = r'''subscription MyQuery($id: String!) {
  channel_table7(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable8 = r'''subscription MyQuery($id: String!) {
  channel_table8(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable9 = r'''subscription MyQuery($id: String!) {
  channel_table9(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';

  static String getMsgsFromTable10 = r'''subscription MyQuery($id: String!) {
  channel_table10(where: {channelId: {_eq: $id}}) {
    msg
    receiverName
    senderName
    timeStamp
  }
}
''';
  static String findGetMsgQuery(int no) {
    switch (no) {
      case 1:
        return Queries.getMsgsFromTable1;
      case 2:
        return Queries.getMsgsFromTable2;
      case 3:
        return Queries.getMsgsFromTable3;
      case 4:
        return Queries.getMsgsFromTable4;
      case 5:
        return Queries.getMsgsFromTable5;
      case 6:
        return Queries.getMsgsFromTable6;
      case 7:
        return Queries.getMsgsFromTable7;
      case 8:
        return Queries.getMsgsFromTable8;
      case 9:
        return Queries.getMsgsFromTable9;
      case 10:
        return Queries.getMsgsFromTable10;
      default:
        return Queries.getMsgsFromTable1;
    }
  }

  static String findCreateMsgQuery(int no) {
    switch (no) {
      case 1:
        return Queries.sendMsgOnTable1;

      case 2:
        return Queries.sendMsgOnTable2;

      case 3:
        return Queries.sendMsgOnTable3;

      case 4:
        return Queries.sendMsgOnTable4;

      case 5:
        return Queries.sendMsgOnTable5;

      case 6:
        return Queries.sendMsgOnTable6;

      case 7:
        return Queries.sendMsgOnTable7;

      case 8:
        return Queries.sendMsgOnTable8;

      case 9:
        return Queries.sendMsgOnTable9;

      case 10:
        return Queries.sendMsgOnTable10;

      default:
        return Queries.sendMsgOnTable1;
    }
  }

  static String getTableName(int mod) {
    switch (mod) {
      case 1:
        return "channel_table1";
      case 2:
        return "channel_table2";
      case 3:
        return "channel_table3";
      case 4:
        return "channel_table4";
      case 5:
        return "channel_table5";
      case 6:
        return "channel_table6";
      case 7:
        return "channel_table7";
      case 8:
        return "channel_table8";
      case 9:
        return "channel_table9";
      case 10:
        return "channel_table10";
      
      default:
        return "channel_table1";
    }
  }
}
