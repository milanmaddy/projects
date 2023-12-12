class ItemAvailableModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  ItemAvailableModel({this.statusCode, this.isSuccess, this.data});

  ItemAvailableModel.fromJson(Map<String, dynamic> json) {
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
  List<Countries>? countries;

  Data({this.countries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  String? countryId;
  String? countryFlagUrl;
  String? countryName;
  String? countryCode;
  String? currencyCode;
  String? currencyName;
  String? currencySymbol;
  String? countryFlag;
  String? telephoneCode;
  bool? isActive;

  Countries(
      {this.countryId,
        this.countryFlagUrl,
        this.countryName,
        this.countryCode,
        this.currencyCode,
        this.currencyName,
        this.currencySymbol,
        this.countryFlag,
        this.telephoneCode,
        this.isActive});

  Countries.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryFlagUrl = json['countryFlagUrl'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    currencyCode = json['currencyCode'];
    currencyName = json['currencyName'];
    currencySymbol = json['currencySymbol'];
    countryFlag = json['countryFlag'];
    telephoneCode = json['telephoneCode'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['countryFlagUrl'] = this.countryFlagUrl;
    data['countryName'] = this.countryName;
    data['countryCode'] = this.countryCode;
    data['currencyCode'] = this.currencyCode;
    data['currencyName'] = this.currencyName;
    data['currencySymbol'] = this.currencySymbol;
    data['countryFlag'] = this.countryFlag;
    data['telephoneCode'] = this.telephoneCode;
    data['isActive'] = this.isActive;
    return data;
  }
}