class BroadcastTypeModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  BroadcastTypeModel({this.statusCode, this.isSuccess, this.data});

  BroadcastTypeModel.fromJson(Map<String, dynamic> json) {
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
  Pagination? pagination;
  List<Broadcasts>? broadcasts;

  Data({this.pagination, this.broadcasts});

  Data.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['broadcasts'] != null) {
      broadcasts = <Broadcasts>[];
      json['broadcasts'].forEach((v) {
        broadcasts!.add(new Broadcasts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.broadcasts != null) {
      data['broadcasts'] = this.broadcasts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? perPage;
  int? currentPage;
  int? lastPage;

  Pagination({this.totalItems, this.perPage, this.currentPage, this.lastPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['perPage'] = this.perPage;
    data['currentPage'] = this.currentPage;
    data['lastPage'] = this.lastPage;
    return data;
  }
}

class Broadcasts {
  String? broadcastId;
  String? broadcastType;
  String? broadcastText;
  String? postedAt;
  ToCountry? toCountry;

  Broadcasts(
      {this.broadcastId,
        this.broadcastType,
        this.broadcastText,
        this.postedAt,
        this.toCountry});

  Broadcasts.fromJson(Map<String, dynamic> json) {
    broadcastId = json['broadcastId'];
    broadcastType = json['broadcastType'];
    broadcastText = json['broadcastText'];
    postedAt = json['postedAt'];
    toCountry = json['toCountry'] != null
        ? new ToCountry.fromJson(json['toCountry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['broadcastId'] = this.broadcastId;
    data['broadcastType'] = this.broadcastType;
    data['broadcastText'] = this.broadcastText;
    data['postedAt'] = this.postedAt;
    if (this.toCountry != null) {
      data['toCountry'] = this.toCountry!.toJson();
    }
    return data;
  }
}

class ToCountry {
  String? countryId;
  String? countryFlagUrl;
  String? countryName;

  ToCountry({this.countryId, this.countryFlagUrl, this.countryName});

  ToCountry.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryFlagUrl = json['countryFlagUrl'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['countryFlagUrl'] = this.countryFlagUrl;
    data['countryName'] = this.countryName;
    return data;
  }
}