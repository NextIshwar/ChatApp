class UserData {
  UserUsersAggregate? userUsersAggregate;

  UserData({this.userUsersAggregate});

  UserData.fromJson(Map<String, dynamic> json) {
    userUsersAggregate = json['User_users_aggregate'] != null
        ? new UserUsersAggregate.fromJson(json['User_users_aggregate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userUsersAggregate != null) {
      data['User_users_aggregate'] = this.userUsersAggregate!.toJson();
    }
    return data;
  }
}

class UserUsersAggregate {
  List<Nodes>? nodes;

  UserUsersAggregate({this.nodes});

  UserUsersAggregate.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = [];
      json['nodes'].forEach((v) {
        nodes!.add(new Nodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodes != null) {
      data['nodes'] = this.nodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nodes {
  String? name;
  String? id;
  String? email;
  String? profileImage;

  Nodes({this.name, this.id, this.email, this.profileImage});

  Nodes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
