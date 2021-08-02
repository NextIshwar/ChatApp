class Status {
  List<UserStatus>? userStatus;

  Status({this.userStatus});

  Status.fromJson(Map<String, dynamic> json) {
    if (json['User_status'] != null) {
      userStatus = [];
      json['User_status'].forEach((v) {
        userStatus!.add(new UserStatus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userStatus != null) {
      data['User_status'] = this.userStatus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserStatus {
  int? id;
  String? userName;
  String? textStatus;
  String? userId;
  String? timeStamp;

  UserStatus(
      {this.id, this.userName, this.textStatus, this.userId, this.timeStamp});

  UserStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    textStatus = json['textStatus'];
    userId = json['userId'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['textStatus'] = this.textStatus;
    data['userId'] = this.userId;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}
