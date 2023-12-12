class InboxChatModel {
  int? statusCode;
  bool? isSuccess;
  String? message;
  Data? data;

  InboxChatModel({this.statusCode, this.isSuccess, this.message, this.data});

  InboxChatModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Conversion>? conversion;

  Data({this.conversion});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['conversion'] != null) {
      conversion = <Conversion>[];
      json['conversion'].forEach((v) {
        conversion!.add(new Conversion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conversion != null) {
      data['conversion'] = this.conversion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversion{
  String? messageId;
  String? userId;
  Content? content;
  String? messagedAt;
  String? messageDate;
  String? messageTime;
  int? type;

  Conversion(
      {this.messageId,
        this.userId,
        this.content,
        this.messagedAt,
        this.messageDate,
        this.messageTime,
        this.type});

  Conversion.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    userId = json['userId'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    messagedAt = json['messagedAt'];
    messageDate = json['messageDate'];
    messageTime = json['messageTime'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messageId'] = this.messageId;
    data['userId'] = this.userId;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['messagedAt'] = this.messagedAt;
    data['messageDate'] = this.messageDate;
    data['messageTime'] = this.messageTime;
    data['type'] = this.type;
    return data;
  }
}

class Content {
  List<Files>? files;
  String? message;

  Content({this.files, this.message});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Files {
  String? fileKey;
  String? fileUrl;
  String? fileType;

  Files({this.fileKey, this.fileUrl, this.fileType});

  Files.fromJson(Map<String, dynamic> json) {
    fileKey = json['fileKey'];
    fileUrl = json['fileUrl'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileKey'] = this.fileKey;
    data['fileUrl'] = this.fileUrl;
    data['fileType'] = this.fileType;
    return data;
  }
}