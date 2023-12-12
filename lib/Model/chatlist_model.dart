class ChatListModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  ChatListModel({this.statusCode, this.isSuccess, this.data});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['isSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<LeftMenuList>? leftMenuList;

  Data({this.leftMenuList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['leftMenuList'] != null) {
      leftMenuList = <LeftMenuList>[];
      json['leftMenuList'].forEach((v) {
        leftMenuList!.add(new LeftMenuList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leftMenuList != null) {
      data['leftMenuList'] = this.leftMenuList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeftMenuList {
  String? userId;
  String? inboxId;
  String? fullName;
  String? profileImageUrl;
  bool? isOnline;
  String? lastMessage;
  String? lastMessageTime;
  String? updatedAt;
  int? messageCount;
  int? type;

  LeftMenuList(
      {this.userId,
        this.inboxId,
        this.fullName,
        this.profileImageUrl,
        this.isOnline,
        this.lastMessage,
        this.lastMessageTime,
        this.updatedAt,
        this.messageCount,
        this.type});

  LeftMenuList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    inboxId = json['inboxId'];
    fullName = json['fullName'];
    profileImageUrl = json['profileImageUrl'];
    isOnline = json['isOnline'];
    lastMessage = json['lastMessage'];
    lastMessageTime = json['lastMessageTime'];
    updatedAt = json['updatedAt'];
    messageCount = json['messageCount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['inboxId'] = this.inboxId;
    data['fullName'] = this.fullName;
    data['profileImageUrl'] = this.profileImageUrl;
    data['isOnline'] = this.isOnline;
    data['lastMessage'] = this.lastMessage;
    data['lastMessageTime'] = this.lastMessageTime;
    data['updatedAt'] = this.updatedAt;
    data['messageCount'] = this.messageCount;
    data['type'] = this.type;
    return data;
  }
}