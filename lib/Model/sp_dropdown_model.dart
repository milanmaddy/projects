class SparePartsDropDownModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  SparePartsDropDownModel({this.statusCode, this.isSuccess, this.data});

  SparePartsDropDownModel.fromJson(Map<String, dynamic> json) {
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
  List<CarMakersSP>? carMakers;
  List<CarConditionsSP>? carConditions;
  List<SparePartCategory>? sparePartCategory;
  List<CountriesSP>? countries;

  Data(
      {this.carMakers,
        this.carConditions,
        this.sparePartCategory,
        this.countries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['carMakers'] != null) {
      carMakers = <CarMakersSP>[];
      json['carMakers'].forEach((v) {
        carMakers!.add(new CarMakersSP.fromJson(v));
      });
    }
    if (json['carConditions'] != null) {
      carConditions = <CarConditionsSP>[];
      json['carConditions'].forEach((v) {
        carConditions!.add(new CarConditionsSP.fromJson(v));
      });
    }
    if (json['sparePartCategory'] != null) {
      sparePartCategory = <SparePartCategory>[];
      json['sparePartCategory'].forEach((v) {
        sparePartCategory!.add(new SparePartCategory.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <CountriesSP>[];
      json['countries'].forEach((v) {
        countries!.add(new CountriesSP.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carMakers != null) {
      data['carMakers'] = this.carMakers!.map((v) => v.toJson()).toList();
    }
    if (this.carConditions != null) {
      data['carConditions'] =
          this.carConditions!.map((v) => v.toJson()).toList();
    }
    if (this.sparePartCategory != null) {
      data['sparePartCategory'] =
          this.sparePartCategory!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarMakersSP {
  String? carMakerId;
  String? title;

  CarMakersSP({this.carMakerId, this.title});

  CarMakersSP.fromJson(Map<String, dynamic> json) {
    carMakerId = json['carMakerId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carMakerId'] = this.carMakerId;
    data['title'] = this.title;
    return data;
  }
}

class CarConditionsSP {
  String? carConditionId;
  String? title;

  CarConditionsSP({this.carConditionId, this.title});

  CarConditionsSP.fromJson(Map<String, dynamic> json) {
    carConditionId = json['carConditionId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carConditionId'] = this.carConditionId;
    data['title'] = this.title;
    return data;
  }
}

class SparePartCategory {
  String? sparePartCategoryId;
  String? title;

  SparePartCategory({this.sparePartCategoryId, this.title});

  SparePartCategory.fromJson(Map<String, dynamic> json) {
    sparePartCategoryId = json['sparePartCategoryId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sparePartCategoryId'] = this.sparePartCategoryId;
    data['title'] = this.title;
    return data;
  }
}

class CountriesSP {
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

  CountriesSP(
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

  CountriesSP.fromJson(Map<String, dynamic> json) {
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