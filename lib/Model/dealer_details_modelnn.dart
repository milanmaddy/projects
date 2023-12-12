// class DealerDetailsModelWithLogin {
//   int? statusCode;
//   bool? isSuccess;
//   Data? data;
//
//   DealerDetailsModelWithLogin({this.statusCode, this.isSuccess, this.data});
//
//   DealerDetailsModelWithLogin.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     isSuccess = json['isSuccess'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['isSuccess'] = this.isSuccess;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   Business? business;
//
//   Data({this.business});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     business = json['business'] != null
//         ? new Business.fromJson(json['business'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.business != null) {
//       data['business'] = this.business!.toJson();
//     }
//     return data;
//   }
// }
//
// class Business {
//   String? userId;
//   String? profileImageUrl;
//   String? fullName;
//   String? emailAddress;
//   String? phoneCountryCode;
//   String? phoneNumber;
//   UserSettings? userSettings;
//   UserColor? userColor;
//   bool? isActive;
//   String? createdAt;
//   Country? country;
//   State? state;
//   City? city;
//   BusinessAccount? businessAccount;
//   Role? role;
//   bool? isRated;
//
//   Business(
//       {this.userId,
//         this.profileImageUrl,
//         this.fullName,
//         this.emailAddress,
//         this.phoneCountryCode,
//         this.phoneNumber,
//         this.userSettings,
//         this.userColor,
//         this.isActive,
//         this.createdAt,
//         this.country,
//         this.state,
//         this.city,
//         this.businessAccount,
//         this.role,
//         this.isRated});
//
//   Business.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     profileImageUrl = json['profileImageUrl'];
//     fullName = json['fullName'];
//     emailAddress = json['emailAddress'];
//     phoneCountryCode = json['phoneCountryCode'];
//     phoneNumber = json['phoneNumber'];
//     userSettings = json['userSettings'] != null
//         ? new UserSettings.fromJson(json['userSettings'])
//         : null;
//     userColor = json['userColor'] != null
//         ? new UserColor.fromJson(json['userColor'])
//         : null;
//     isActive = json['isActive'];
//     createdAt = json['createdAt'];
//     country =
//     json['country'] != null ? new Country.fromJson(json['country']) : null;
//     state = json['state'] != null ? new State.fromJson(json['state']) : null;
//     city = json['city'] != null ? new City.fromJson(json['city']) : null;
//     businessAccount = json['businessAccount'] != null
//         ? new BusinessAccount.fromJson(json['businessAccount'])
//         : null;
//     role = json['role'] != null ? new Role.fromJson(json['role']) : null;
//     isRated = json['isRated'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['profileImageUrl'] = this.profileImageUrl;
//     data['fullName'] = this.fullName;
//     data['emailAddress'] = this.emailAddress;
//     data['phoneCountryCode'] = this.phoneCountryCode;
//     data['phoneNumber'] = this.phoneNumber;
//     if (this.userSettings != null) {
//       data['userSettings'] = this.userSettings!.toJson();
//     }
//     if (this.userColor != null) {
//       data['userColor'] = this.userColor!.toJson();
//     }
//     data['isActive'] = this.isActive;
//     data['createdAt'] = this.createdAt;
//     if (this.country != null) {
//       data['country'] = this.country!.toJson();
//     }
//     if (this.state != null) {
//       data['state'] = this.state!.toJson();
//     }
//     if (this.city != null) {
//       data['city'] = this.city!.toJson();
//     }
//     if (this.businessAccount != null) {
//       data['businessAccount'] = this.businessAccount!.toJson();
//     }
//     if (this.role != null) {
//       data['role'] = this.role!.toJson();
//     }
//     data['isRated'] = this.isRated;
//     return data;
//   }
// }
//
// class UserSettings {
//   bool? isOnline;
//
//   UserSettings({this.isOnline});
//
//   UserSettings.fromJson(Map<String, dynamic> json) {
//     isOnline = json['isOnline'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isOnline'] = this.isOnline;
//     return data;
//   }
// }
//
// class UserColor {
//   String? background;
//   String? userNameColor;
//   String? backgroundHexCode;
//   String? userNameColorHexCode;
//
//   UserColor(
//       {this.background,
//         this.userNameColor,
//         this.backgroundHexCode,
//         this.userNameColorHexCode});
//
//   UserColor.fromJson(Map<String, dynamic> json) {
//     background = json['Background'];
//     userNameColor = json['UserNameColor'];
//     backgroundHexCode = json['BackgroundHexCode'];
//     userNameColorHexCode = json['UserNameColorHexCode'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Background'] = this.background;
//     data['UserNameColor'] = this.userNameColor;
//     data['BackgroundHexCode'] = this.backgroundHexCode;
//     data['UserNameColorHexCode'] = this.userNameColorHexCode;
//     return data;
//   }
// }
//
// class Country {
//   String? countryId;
//   String? countryFlagUrl;
//   String? countryName;
//   String? countryCode;
//   String? currencyCode;
//   String? currencyName;
//   String? currencySymbol;
//   String? countryFlag;
//   String? telephoneCode;
//   bool? isActive;
//
//   Country(
//       {this.countryId,
//         this.countryFlagUrl,
//         this.countryName,
//         this.countryCode,
//         this.currencyCode,
//         this.currencyName,
//         this.currencySymbol,
//         this.countryFlag,
//         this.telephoneCode,
//         this.isActive});
//
//   Country.fromJson(Map<String, dynamic> json) {
//     countryId = json['countryId'];
//     countryFlagUrl = json['countryFlagUrl'];
//     countryName = json['countryName'];
//     countryCode = json['countryCode'];
//     currencyCode = json['currencyCode'];
//     currencyName = json['currencyName'];
//     currencySymbol = json['currencySymbol'];
//     countryFlag = json['countryFlag'];
//     telephoneCode = json['telephoneCode'];
//     isActive = json['isActive'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['countryId'] = this.countryId;
//     data['countryFlagUrl'] = this.countryFlagUrl;
//     data['countryName'] = this.countryName;
//     data['countryCode'] = this.countryCode;
//     data['currencyCode'] = this.currencyCode;
//     data['currencyName'] = this.currencyName;
//     data['currencySymbol'] = this.currencySymbol;
//     data['countryFlag'] = this.countryFlag;
//     data['telephoneCode'] = this.telephoneCode;
//     data['isActive'] = this.isActive;
//     return data;
//   }
// }
//
// class State {
//   String? stateId;
//   String? stateName;
//
//   State({this.stateId, this.stateName});
//
//   State.fromJson(Map<String, dynamic> json) {
//     stateId = json['stateId'];
//     stateName = json['stateName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['stateId'] = this.stateId;
//     data['stateName'] = this.stateName;
//     return data;
//   }
// }
//
// class City {
//   String? cityId;
//   String? cityName;
//
//   City({this.cityId, this.cityName});
//
//   City.fromJson(Map<String, dynamic> json) {
//     cityId = json['cityId'];
//     cityName = json['cityName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cityId'] = this.cityId;
//     data['cityName'] = this.cityName;
//     return data;
//   }
// }
//
// class BusinessAccount {
//   String? businessAccountId;
//   String? businessLogoUrl;
//   String? businessName;
//   String? phoneCountryCode;
//   String? businessPhoneCountryCode;
//   String? businessPhoneNumber;
//   Null? averageRating;
//   String? websiteUrl;
//   BusinessType? businessType;
//
//   BusinessAccount(
//       {this.businessAccountId,
//         this.businessLogoUrl,
//         this.businessName,
//         this.phoneCountryCode,
//         this.businessPhoneCountryCode,
//         this.businessPhoneNumber,
//         this.averageRating,
//         this.websiteUrl,
//         this.businessType});
//
//   BusinessAccount.fromJson(Map<String, dynamic> json) {
//     businessAccountId = json['businessAccountId'];
//     businessLogoUrl = json['businessLogoUrl'];
//     businessName = json['businessName'];
//     phoneCountryCode = json['phoneCountryCode'];
//     businessPhoneCountryCode = json['businessPhoneCountryCode'];
//     businessPhoneNumber = json['businessPhoneNumber'];
//     averageRating = json['averageRating'];
//     websiteUrl = json['websiteUrl'];
//     businessType = json['businessType'] != null
//         ? new BusinessType.fromJson(json['businessType'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['businessAccountId'] = this.businessAccountId;
//     data['businessLogoUrl'] = this.businessLogoUrl;
//     data['businessName'] = this.businessName;
//     data['phoneCountryCode'] = this.phoneCountryCode;
//     data['businessPhoneCountryCode'] = this.businessPhoneCountryCode;
//     data['businessPhoneNumber'] = this.businessPhoneNumber;
//     data['averageRating'] = this.averageRating;
//     data['websiteUrl'] = this.websiteUrl;
//     if (this.businessType != null) {
//       data['businessType'] = this.businessType!.toJson();
//     }
//     return data;
//   }
// }
//
// class BusinessType {
//   String? businessTypeId;
//   String? title;
//   String? description;
//
//   BusinessType({this.businessTypeId, this.title, this.description});
//
//   BusinessType.fromJson(Map<String, dynamic> json) {
//     businessTypeId = json['businessTypeId'];
//     title = json['title'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['businessTypeId'] = this.businessTypeId;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     return data;
//   }
// }
//
// class Role {
//   String? roleId;
//   String? roleName;
//
//   Role({this.roleId, this.roleName});
//
//   Role.fromJson(Map<String, dynamic> json) {
//     roleId = json['roleId'];
//     roleName = json['roleName'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['roleId'] = this.roleId;
//     data['roleName'] = this.roleName;
//     return data;
//   }
// }