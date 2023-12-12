class MyEnquiryModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  MyEnquiryModel({this.statusCode, this.isSuccess, this.data});

  MyEnquiryModel.fromJson(Map<String, dynamic> json) {
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
  List<Enquiries>? enquiries;

  Data({this.pagination, this.enquiries});

  Data.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['enquiries'] != null) {
      enquiries = <Enquiries>[];
      json['enquiries'].forEach((v) {
        enquiries!.add(new Enquiries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.enquiries != null) {
      data['enquiries'] = this.enquiries!.map((v) => v.toJson()).toList();
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

class Enquiries {
  String? enquiryId;
  String? enquiryType;
  String? productId;
  String? enquiryText;
  String? postedAt;
  From? from;
  Vehicle? vehicle;
  Garage? garage;
  Sparepart? sparepart;

  Enquiries(
      {this.enquiryId,
        this.enquiryType,
        this.productId,
        this.enquiryText,
        this.postedAt,
        this.from,
        this.vehicle,
        this.garage,
        this.sparepart});

  Enquiries.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiryId'];
    enquiryType = json['enquiryType'];
    productId = json['productId'];
    enquiryText = json['enquiryText'];
    postedAt = json['postedAt'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    vehicle =
    json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    garage =
    json['garage'] != null ? new Garage.fromJson(json['garage']) : null;
    sparepart = json['sparepart'] != null
        ? new Sparepart.fromJson(json['sparepart'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiryId'] = this.enquiryId;
    data['enquiryType'] = this.enquiryType;
    data['productId'] = this.productId;
    data['enquiryText'] = this.enquiryText;
    data['postedAt'] = this.postedAt;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    if (this.garage != null) {
      data['garage'] = this.garage!.toJson();
    }
    if (this.sparepart != null) {
      data['sparepart'] = this.sparepart!.toJson();
    }
    return data;
  }
}

class From {
  String? userId;
  String? profileImageUrl;
  String? fullName;
  String? emailAddress;
  String? phoneCountryCode;
  String? phoneNumber;
  UserSettings? userSettings;
  UserColor? userColor;
  bool? isActive;
  String? createdAt;
  Country? country;
  State? state;
  City? city;
  BusinessAccount? businessAccount;
  Role? role;

  From(
      {this.userId,
        this.profileImageUrl,
        this.fullName,
        this.emailAddress,
        this.phoneCountryCode,
        this.phoneNumber,
        this.userSettings,
        this.userColor,
        this.isActive,
        this.createdAt,
        this.country,
        this.state,
        this.city,
        this.businessAccount,
        this.role});

  From.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    profileImageUrl = json['profileImageUrl'];
    fullName = json['fullName'];
    emailAddress = json['emailAddress'];
    phoneCountryCode = json['phoneCountryCode'];
    phoneNumber = json['phoneNumber'];
    userSettings = json['userSettings'] != null
        ? new UserSettings.fromJson(json['userSettings'])
        : null;
    userColor = json['userColor'] != null
        ? new UserColor.fromJson(json['userColor'])
        : null;
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    businessAccount = json['businessAccount'] != null
        ? new BusinessAccount.fromJson(json['businessAccount'])
        : null;
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['profileImageUrl'] = this.profileImageUrl;
    data['fullName'] = this.fullName;
    data['emailAddress'] = this.emailAddress;
    data['phoneCountryCode'] = this.phoneCountryCode;
    data['phoneNumber'] = this.phoneNumber;
    if (this.userSettings != null) {
      data['userSettings'] = this.userSettings!.toJson();
    }
    if (this.userColor != null) {
      data['userColor'] = this.userColor!.toJson();
    }
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.businessAccount != null) {
      data['businessAccount'] = this.businessAccount!.toJson();
    }
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

class UserSettings {
  bool? isOnline;

  UserSettings({this.isOnline});

  UserSettings.fromJson(Map<String, dynamic> json) {
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOnline'] = this.isOnline;
    return data;
  }
}

class UserColor {
  String? background;
  String? userNameColor;
  String? backgroundHexCode;
  String? userNameColorHexCode;

  UserColor(
      {this.background,
        this.userNameColor,
        this.backgroundHexCode,
        this.userNameColorHexCode});

  UserColor.fromJson(Map<String, dynamic> json) {
    background = json['Background'];
    userNameColor = json['UserNameColor'];
    backgroundHexCode = json['BackgroundHexCode'];
    userNameColorHexCode = json['UserNameColorHexCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Background'] = this.background;
    data['UserNameColor'] = this.userNameColor;
    data['BackgroundHexCode'] = this.backgroundHexCode;
    data['UserNameColorHexCode'] = this.userNameColorHexCode;
    return data;
  }
}

class Country {
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

  Country(
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

  Country.fromJson(Map<String, dynamic> json) {
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

class State {
  String? stateId;
  String? stateName;

  State({this.stateId, this.stateName});

  State.fromJson(Map<String, dynamic> json) {
    stateId = json['stateId'];
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    return data;
  }
}

class City {
  String? cityId;
  String? cityName;

  City({this.cityId, this.cityName});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    return data;
  }
}

class BusinessAccount {
  String? businessAccountId;
  String? businessLogoUrl;
  String? businessName;
  String? phoneCountryCode;
  String? businessPhoneCountryCode;
  String? businessPhoneNumber;
  Null? averageRating;
  String? websiteUrl;
  BusinessType? businessType;

  BusinessAccount(
      {this.businessAccountId,
        this.businessLogoUrl,
        this.businessName,
        this.phoneCountryCode,
        this.businessPhoneCountryCode,
        this.businessPhoneNumber,
        this.averageRating,
        this.websiteUrl,
        this.businessType});

  BusinessAccount.fromJson(Map<String, dynamic> json) {
    businessAccountId = json['businessAccountId'];
    businessLogoUrl = json['businessLogoUrl'];
    businessName = json['businessName'];
    phoneCountryCode = json['phoneCountryCode'];
    businessPhoneCountryCode = json['businessPhoneCountryCode'];
    businessPhoneNumber = json['businessPhoneNumber'];
    averageRating = json['averageRating'];
    websiteUrl = json['websiteUrl'];
    businessType = json['businessType'] != null
        ? new BusinessType.fromJson(json['businessType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessAccountId'] = this.businessAccountId;
    data['businessLogoUrl'] = this.businessLogoUrl;
    data['businessName'] = this.businessName;
    data['phoneCountryCode'] = this.phoneCountryCode;
    data['businessPhoneCountryCode'] = this.businessPhoneCountryCode;
    data['businessPhoneNumber'] = this.businessPhoneNumber;
    data['averageRating'] = this.averageRating;
    data['websiteUrl'] = this.websiteUrl;
    if (this.businessType != null) {
      data['businessType'] = this.businessType!.toJson();
    }
    return data;
  }
}

class BusinessType {
  String? businessTypeId;
  String? title;
  String? description;

  BusinessType({this.businessTypeId, this.title, this.description});

  BusinessType.fromJson(Map<String, dynamic> json) {
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

class Role {
  String? roleId;
  String? roleName;

  Role({this.roleId, this.roleName});

  Role.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    return data;
  }
}

class Vehicle {
  String? vehicleId;
  String? vehiclePrimaryImageUrl;
  String? userId;
  String? manufacturingYear;
  String? description;
  String? mileage;
  String? currency;
  String? price;
  String? youtubeVideoUrl;
  Null? averageRating;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  Maker? maker;
  Model? model;

  Vehicle(
      {this.vehicleId,
        this.vehiclePrimaryImageUrl,
        this.userId,
        this.manufacturingYear,
        this.description,
        this.mileage,
        this.currency,
        this.price,
        this.youtubeVideoUrl,
        this.averageRating,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.maker,
        this.model});

  Vehicle.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    vehiclePrimaryImageUrl = json['vehiclePrimaryImageUrl'];
    userId = json['userId'];
    manufacturingYear = json['manufacturingYear'];
    description = json['description'];
    mileage = json['mileage'];
    currency = json['currency'];
    price = json['price'];
    youtubeVideoUrl = json['youtubeVideoUrl'];
    averageRating = json['averageRating'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    maker = json['maker'] != null ? new Maker.fromJson(json['maker']) : null;
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleId'] = this.vehicleId;
    data['vehiclePrimaryImageUrl'] = this.vehiclePrimaryImageUrl;
    data['userId'] = this.userId;
    data['manufacturingYear'] = this.manufacturingYear;
    data['description'] = this.description;
    data['mileage'] = this.mileage;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['youtubeVideoUrl'] = this.youtubeVideoUrl;
    data['averageRating'] = this.averageRating;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.maker != null) {
      data['maker'] = this.maker!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    return data;
  }
}

class Maker {
  String? carMakerId;
  String? carMakerName;

  Maker({this.carMakerId, this.carMakerName});

  Maker.fromJson(Map<String, dynamic> json) {
    carMakerId = json['carMakerId'];
    carMakerName = json['carMakerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carMakerId'] = this.carMakerId;
    data['carMakerName'] = this.carMakerName;
    return data;
  }
}

class Model {
  String? carModelId;
  String? carModelName;

  Model({this.carModelId, this.carModelName});

  Model.fromJson(Map<String, dynamic> json) {
    carModelId = json['carModelId'];
    carModelName = json['carModelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carModelId'] = this.carModelId;
    data['carModelName'] = this.carModelName;
    return data;
  }
}

class Garage {
  String? garageId;
  String? garagePrimaryImageUrl;
  String? garageSecondaryImageUrl;
  String? userId;
  String? garageName;
  String? garageStartTime;
  String? garageEndTime;
  String? contactPersonName;
  String? contactPersonEmail;
  String? contactPersonNumber;
  String? websiteUrl;
  String? services;
  String? description;
  Null? averageRating;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Garage(
      {this.garageId,
        this.garagePrimaryImageUrl,
        this.garageSecondaryImageUrl,
        this.userId,
        this.garageName,
        this.garageStartTime,
        this.garageEndTime,
        this.contactPersonName,
        this.contactPersonEmail,
        this.contactPersonNumber,
        this.websiteUrl,
        this.services,
        this.description,
        this.averageRating,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Garage.fromJson(Map<String, dynamic> json) {
    garageId = json['garageId'];
    garagePrimaryImageUrl = json['garagePrimaryImageUrl'];
    garageSecondaryImageUrl = json['garageSecondaryImageUrl'];
    userId = json['userId'];
    garageName = json['garageName'];
    garageStartTime = json['garageStartTime'];
    garageEndTime = json['garageEndTime'];
    contactPersonName = json['contactPersonName'];
    contactPersonEmail = json['contactPersonEmail'];
    contactPersonNumber = json['contactPersonNumber'];
    websiteUrl = json['websiteUrl'];
    services = json['services'];
    description = json['description'];
    averageRating = json['averageRating'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['garageId'] = this.garageId;
    data['garagePrimaryImageUrl'] = this.garagePrimaryImageUrl;
    data['garageSecondaryImageUrl'] = this.garageSecondaryImageUrl;
    data['userId'] = this.userId;
    data['garageName'] = this.garageName;
    data['garageStartTime'] = this.garageStartTime;
    data['garageEndTime'] = this.garageEndTime;
    data['contactPersonName'] = this.contactPersonName;
    data['contactPersonEmail'] = this.contactPersonEmail;
    data['contactPersonNumber'] = this.contactPersonNumber;
    data['websiteUrl'] = this.websiteUrl;
    data['services'] = this.services;
    data['description'] = this.description;
    data['averageRating'] = this.averageRating;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Sparepart {
  String? sparePartId;
  String? sparePartPrimaryImageUrl;
  String? userId;
  String? manufacturingYear;
  String? title;
  String? description;
  String? currency;
  String? price;
  String? averageRating;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  Maker? maker;
  Model? model;

  Sparepart(
      {this.sparePartId,
        this.sparePartPrimaryImageUrl,
        this.userId,
        this.manufacturingYear,
        this.title,
        this.description,
        this.currency,
        this.price,
        this.averageRating,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.maker,
        this.model});

  Sparepart.fromJson(Map<String, dynamic> json) {
    sparePartId = json['sparePartId'];
    sparePartPrimaryImageUrl = json['sparePartPrimaryImageUrl'];
    userId = json['userId'];
    manufacturingYear = json['manufacturingYear'];
    title = json['title'];
    description = json['description'];
    currency = json['currency'];
    price = json['price'];
    averageRating = json['averageRating'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    maker = json['maker'] != null ? new Maker.fromJson(json['maker']) : null;
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sparePartId'] = this.sparePartId;
    data['sparePartPrimaryImageUrl'] = this.sparePartPrimaryImageUrl;
    data['userId'] = this.userId;
    data['manufacturingYear'] = this.manufacturingYear;
    data['title'] = this.title;
    data['description'] = this.description;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['averageRating'] = this.averageRating;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.maker != null) {
      data['maker'] = this.maker!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    return data;
  }
}