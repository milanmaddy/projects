class CMSModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  CMSModel({this.statusCode, this.isSuccess, this.data});

  CMSModel.fromJson(Map<String, dynamic> json) {
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
  String? pageId;
  String? pageTitle;
  String? pageContent;

  Data({this.pageId, this.pageTitle, this.pageContent});

  Data.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    pageTitle = json['pageTitle'];
    pageContent = json['pageContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageId'] = this.pageId;
    data['pageTitle'] = this.pageTitle;
    data['pageContent'] = this.pageContent;
    return data;
  }
}