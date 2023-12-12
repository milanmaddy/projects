class RegisterOptionModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  RegisterOptionModel({this.statusCode, this.isSuccess, this.data});

  RegisterOptionModel.fromJson(Map<String, dynamic> json) {
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
  List<Roles>? roles;
  List<Countries>? countries;
  List<BusinessTypes>? businessTypes;

  Data({this.roles, this.countries, this.businessTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['businessTypes'] != null) {
      businessTypes = <BusinessTypes>[];
      json['businessTypes'].forEach((v) {
        businessTypes!.add(new BusinessTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.businessTypes != null) {
      data['businessTypes'] =
          this.businessTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  String? roleId;
  String? title;
  String? description;

  Roles({this.roleId, this.title, this.description});

  Roles.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['title'] = this.title;
    data['description'] = this.description;
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

class BusinessTypes {
  String? businessTypeId;
  String? title;
  String? description;

  BusinessTypes({this.businessTypeId, this.title, this.description});

  BusinessTypes.fromJson(Map<String, dynamic> json) {
    businessTypeId = json['businessTypeId'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessTypeId'] = this.businessTypeId;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}