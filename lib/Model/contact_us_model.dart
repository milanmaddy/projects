class ContactUsModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  ContactUsModel({this.statusCode, this.isSuccess, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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
  Country? country;
  State? state;
  City? city;
  Role? role;

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
        this.country,
        this.state,
        this.city,
        this.role});

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
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
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