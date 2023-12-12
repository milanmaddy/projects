class GarageWishlistModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  GarageWishlistModel({this.statusCode, this.isSuccess, this.data});

  GarageWishlistModel.fromJson(Map<String, dynamic> json) {
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
  List<LikedGarages>? likedGarages;

  Data({this.pagination, this.likedGarages});

  Data.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['likedGarages'] != null) {
      likedGarages = <LikedGarages>[];
      json['likedGarages'].forEach((v) {
        likedGarages!.add(new LikedGarages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.likedGarages != null) {
      data['likedGarages'] = this.likedGarages!.map((v) => v.toJson()).toList();
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

class LikedGarages {
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
  String? averageRating;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  User? user;
  Country? country;
  State? state;
  City? city;
  List<Images>? images;
  bool? isLiked;
  int? enquiryCount;

  LikedGarages(
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
        this.updatedAt,
        this.user,
        this.country,
        this.state,
        this.city,
        this.images,
        this.isLiked,
        this.enquiryCount});

  LikedGarages.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    isLiked = json['isLiked'];
    enquiryCount = json['enquiryCount'];
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
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

class Images {
  String? garageImageId;
  String? imageUrl;

  Images({this.garageImageId, this.imageUrl});

  Images.fromJson(Map<String, dynamic> json) {
    garageImageId = json['garageImageId'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['garageImageId'] = this.garageImageId;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}