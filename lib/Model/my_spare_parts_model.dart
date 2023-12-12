class MySparePartsModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  MySparePartsModel({this.statusCode, this.isSuccess, this.data});

  MySparePartsModel.fromJson(Map<String, dynamic> json) {
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
  List<SpareParts>? spareParts;

  Data({this.pagination, this.spareParts});

  Data.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['spareParts'] != null) {
      spareParts = <SpareParts>[];
      json['spareParts'].forEach((v) {
        spareParts!.add(new SpareParts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.spareParts != null) {
      data['spareParts'] = this.spareParts!.map((v) => v.toJson()).toList();
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

class SpareParts {
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
  User? user;
  Maker? maker;
  Model? model;
  Condition? condition;
  Country? country;
  State? state;
  City? city;
  Category? category;
  SubCategory? subCategory;
  bool? isLiked;
  int? enquiryCount;

  SpareParts(
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
        this.user,
        this.maker,
        this.model,
        this.condition,
        this.country,
        this.state,
        this.city,
        this.category,
        this.subCategory,
        this.isLiked,
        this.enquiryCount});

  SpareParts.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    maker = json['maker'] != null ? new Maker.fromJson(json['maker']) : null;
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
    isLiked = json['isLiked'];
    enquiryCount = json['enquiryCount'];
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.maker != null) {
      data['maker'] = this.maker!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory!.toJson();
    }
    data['isLiked'] = this.isLiked;
    data['enquiryCount'] = this.enquiryCount;
    return data;
  }
}

class User {
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
  Role? role;
  BusinessAccount? businessAccount;

  User(
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
        this.role,
        this.businessAccount});

  User.fromJson(Map<String, dynamic> json) {
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
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    businessAccount = json['businessAccount'] != null
        ? new BusinessAccount.fromJson(json['businessAccount'])
        : null;
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
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.businessAccount != null) {
      data['businessAccount'] = this.businessAccount!.toJson();
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

class BusinessAccount {
  String? businessAccountId;
  String? businessLogoUrl;
  String? businessName;
  String? phoneCountryCode;
  String? businessPhoneCountryCode;
  String? businessPhoneNumber;
  Null? averageRating;
  Null? websiteUrl;
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

class Condition {
  String? carConditionId;
  String? carConditionName;

  Condition({this.carConditionId, this.carConditionName});

  Condition.fromJson(Map<String, dynamic> json) {
    carConditionId = json['carConditionId'];
    carConditionName = json['carConditionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carConditionId'] = this.carConditionId;
    data['carConditionName'] = this.carConditionName;
    return data;
  }
}

class Country {
  String? countryId;
  String? countryName;

  Country({this.countryId, this.countryName});

  Country.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
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

class Category {
  String? categoryId;
  String? categoryTitle;

  Category({this.categoryId, this.categoryTitle});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryTitle = json['categoryTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryTitle'] = this.categoryTitle;
    return data;
  }
}

class SubCategory {
  String? subCategoryId;
  String? subCategoryTitle;

  SubCategory({this.subCategoryId, this.subCategoryTitle});

  SubCategory.fromJson(Map<String, dynamic> json) {
    subCategoryId = json['subCategoryId'];
    subCategoryTitle = json['subCategoryTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryTitle'] = this.subCategoryTitle;
    return data;
  }
}