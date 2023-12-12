class HomePageModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  HomePageModel({this.statusCode, this.isSuccess, this.data});

  HomePageModel.fromJson(Map<String, dynamic> json) {
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
  List<Advertisements>? advertisements;
  List<TrustedPartners>? trustedPartners;
  List<Vehicles>? vehicles;
  List<SpareParts>? spareParts;
  List<Garages>? garages;
  // List<Null>? rentedCars;
  int? totalTrustedPartners;
  int? totalVehicles;
  int? totalRepairgarages;
  int? totalSpareparts;
  List<VehicleTypes>? vehicleTypes;

  Data(
      {this.advertisements,
        this.trustedPartners,
        this.vehicles,
        this.spareParts,
        this.garages,
        // this.rentedCars,
        this.totalTrustedPartners,
        this.totalVehicles,
        this.totalRepairgarages,
        this.totalSpareparts,
        this.vehicleTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['advertisements'] != null) {
      advertisements = <Advertisements>[];
      json['advertisements'].forEach((v) {
        advertisements!.add(new Advertisements.fromJson(v));
      });
    }
    if (json['trustedPartners'] != null) {
      trustedPartners = <TrustedPartners>[];
      json['trustedPartners'].forEach((v) {
        trustedPartners!.add(new TrustedPartners.fromJson(v));
      });
    }
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicles.fromJson(v));
      });
    }
    if (json['spareParts'] != null) {
      spareParts = <SpareParts>[];
      json['spareParts'].forEach((v) {
        spareParts!.add(new SpareParts.fromJson(v));
      });
    }
    if (json['garages'] != null) {
      garages = <Garages>[];
      json['garages'].forEach((v) {
        garages!.add(new Garages.fromJson(v));
      });
    }
    // if (json['rentedCars'] != null) {
    //   rentedCars = <Null>[];
    //   json['rentedCars'].forEach((v) {
    //     rentedCars!.add(new Null.fromJson(v));
    //   });
    // }
    totalTrustedPartners = json['totalTrustedPartners'];
    totalVehicles = json['totalVehicles'];
    totalRepairgarages = json['totalRepairgarages'];
    totalSpareparts = json['totalSpareparts'];
    if (json['vehicleTypes'] != null) {
      vehicleTypes = <VehicleTypes>[];
      json['vehicleTypes'].forEach((v) {
        vehicleTypes!.add(new VehicleTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advertisements != null) {
      data['advertisements'] =
          this.advertisements!.map((v) => v.toJson()).toList();
    }
    if (this.trustedPartners != null) {
      data['trustedPartners'] =
          this.trustedPartners!.map((v) => v.toJson()).toList();
    }
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    if (this.spareParts != null) {
      data['spareParts'] = this.spareParts!.map((v) => v.toJson()).toList();
    }
    if (this.garages != null) {
      data['garages'] = this.garages!.map((v) => v.toJson()).toList();
    }
    // if (this.rentedCars != null) {
    //   data['rentedCars'] = this.rentedCars!.map((v) => v.toJson()).toList();
    // }
    data['totalTrustedPartners'] = this.totalTrustedPartners;
    data['totalVehicles'] = this.totalVehicles;
    data['totalRepairgarages'] = this.totalRepairgarages;
    data['totalSpareparts'] = this.totalSpareparts;
    if (this.vehicleTypes != null) {
      data['vehicleTypes'] = this.vehicleTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Advertisements {
  String? advertisementId;
  String? imageUrl;
  String? title;
  String? startDate;
  String? endDate;
  bool? isActive;

  Advertisements(
      {this.advertisementId,
        this.imageUrl,
        this.title,
        this.startDate,
        this.endDate,
        this.isActive});

  Advertisements.fromJson(Map<String, dynamic> json) {
    advertisementId = json['advertisementId'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advertisementId'] = this.advertisementId;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['isActive'] = this.isActive;
    return data;
  }
}

class TrustedPartners {
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
  BusinessAccountTP? businessAccount;
  Role? role;

  TrustedPartners(
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

  TrustedPartners.fromJson(Map<String, dynamic> json) {
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
        ? new BusinessAccountTP.fromJson(json['businessAccount'])
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

class BusinessAccountTP {
  String? businessAccountId;
  String? businessLogoUrl;
  String? businessName;
  String? phoneCountryCode;
  String? businessPhoneCountryCode;
  String? businessPhoneNumber;
  String? averageRating;
  String? websiteUrl;
  BusinessType? businessType;

  BusinessAccountTP(
      {this.businessAccountId,
        this.businessLogoUrl,
        this.businessName,
        this.phoneCountryCode,
        this.businessPhoneCountryCode,
        this.businessPhoneNumber,
        this.averageRating,
        this.websiteUrl,
        this.businessType});

  BusinessAccountTP.fromJson(Map<String, dynamic> json) {
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


class Vehicles {
  String? vehicleId;
  String? vehiclePrimaryImageUrl;
  String? userId;
  String? manufacturingYear;
  String? description;
  String? mileage;
  String? currency;
  String? price;
  String? youtubeVideoUrl;
  String? averageRating;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  UserV? user;
  Maker? maker;
  Model? model;
  VehicleType? vehicleType;
  Condition? condition;
  Country? country;
  State? state;
  City? city;
  CarFuelType? carFuelType;
  GearBox? gearBox;
  Color? color;
  EngineSize? engineSize;
  String? whenToStart;
  bool? isLiked;

  Vehicles(
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
        this.user,
        this.maker,
        this.model,
        this.vehicleType,
        this.condition,
        this.country,
        this.state,
        this.city,
        this.carFuelType,
        this.gearBox,
        this.color,
        this.engineSize,
        // this.whenToStart,
        this.isLiked});

  Vehicles.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new UserV.fromJson(json['user']) : null;
    maker = json['maker'] != null ? new Maker.fromJson(json['maker']) : null;
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
    vehicleType = json['vehicleType'] != null
        ? new VehicleType.fromJson(json['vehicleType'])
        : null;
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    carFuelType = json['carFuelType'] != null
        ? new CarFuelType.fromJson(json['carFuelType'])
        : null;
    gearBox =
    json['gearBox'] != null ? new GearBox.fromJson(json['gearBox']) : null;
    color = json['color'] != null ? new Color.fromJson(json['color']) : null;
    engineSize = json['engineSize'] != null
        ? new EngineSize.fromJson(json['engineSize'])
        : null;
    // whenToStart = json['whenToStart'];
    isLiked = json['isLiked'];
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.maker != null) {
      data['maker'] = this.maker!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    if (this.vehicleType != null) {
      data['vehicleType'] = this.vehicleType!.toJson();
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
    if (this.carFuelType != null) {
      data['carFuelType'] = this.carFuelType!.toJson();
    }
    if (this.gearBox != null) {
      data['gearBox'] = this.gearBox!.toJson();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    if (this.engineSize != null) {
      data['engineSize'] = this.engineSize!.toJson();
    }
    // data['whenToStart'] = this.whenToStart;
    data['isLiked'] = this.isLiked;
    return data;
  }
}

class UserV {
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
  BusinessAccountV? businessAccount;

  UserV(
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

  UserV.fromJson(Map<String, dynamic> json) {
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
        ? new BusinessAccountV.fromJson(json['businessAccount'])
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

class BusinessAccountV {
  String? businessAccountId;
  String? businessLogoUrl;
  String? businessName;
  String? phoneCountryCode;
  String? businessPhoneCountryCode;
  String? businessPhoneNumber;
  String? averageRating;
  String? websiteUrl;
  BusinessType? businessType;

  BusinessAccountV(
      {this.businessAccountId,
        this.businessLogoUrl,
        this.businessName,
        this.phoneCountryCode,
        this.businessPhoneCountryCode,
        this.businessPhoneNumber,
        this.averageRating,
        this.websiteUrl,
        this.businessType});

  BusinessAccountV.fromJson(Map<String, dynamic> json) {
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

class VehicleType {
  String? carTypeId;
  String? carTypeName;

  VehicleType({this.carTypeId, this.carTypeName});

  VehicleType.fromJson(Map<String, dynamic> json) {
    carTypeId = json['carTypeId'];
    carTypeName = json['carTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carTypeId'] = this.carTypeId;
    data['carTypeName'] = this.carTypeName;
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

class CountryV {
  String? countryId;
  String? countryName;

  CountryV({this.countryId, this.countryName});

  CountryV.fromJson(Map<String, dynamic> json) {
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

class CarFuelType {
  String? carFuelTypeId;
  String? carFuelTypeName;

  CarFuelType({this.carFuelTypeId, this.carFuelTypeName});

  CarFuelType.fromJson(Map<String, dynamic> json) {
    carFuelTypeId = json['carFuelTypeId'];
    carFuelTypeName = json['carFuelTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carFuelTypeId'] = this.carFuelTypeId;
    data['carFuelTypeName'] = this.carFuelTypeName;
    return data;
  }
}

class GearBox {
  String? carGearBoxId;
  String? carGearBoxName;

  GearBox({this.carGearBoxId, this.carGearBoxName});

  GearBox.fromJson(Map<String, dynamic> json) {
    carGearBoxId = json['carGearBoxId'];
    carGearBoxName = json['carGearBoxName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carGearBoxId'] = this.carGearBoxId;
    data['carGearBoxName'] = this.carGearBoxName;
    return data;
  }
}

class Color {
  String? carColorId;
  String? carColorName;

  Color({this.carColorId, this.carColorName});

  Color.fromJson(Map<String, dynamic> json) {
    carColorId = json['carColorId'];
    carColorName = json['carColorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carColorId'] = this.carColorId;
    data['carColorName'] = this.carColorName;
    return data;
  }
}

class EngineSize {
  String? carEngineSizeId;
  String? carEngineSizeName;

  EngineSize({this.carEngineSizeId, this.carEngineSizeName});

  EngineSize.fromJson(Map<String, dynamic> json) {
    carEngineSizeId = json['carEngineSizeId'];
    carEngineSizeName = json['carEngineSizeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carEngineSizeId'] = this.carEngineSizeId;
    data['carEngineSizeName'] = this.carEngineSizeName;
    return data;
  }
}

// class WhenToStart {
//   String? whenToStartId;
//   String? whenToStartTitle;
//
//   WhenToStart({this.whenToStartId, this.whenToStartTitle});
//
//   WhenToStart.fromJson(Map<String, dynamic> json) {
//     whenToStartId = json['whenToStartId'];
//     whenToStartTitle = json['whenToStartTitle'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['whenToStartId'] = this.whenToStartId;
//     data['whenToStartTitle'] = this.whenToStartTitle;
//     return data;
//   }
// }


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
  UserV? user;
  Maker? maker;
  Model? model;
  Condition? condition;
  Country? country;
  State? state;
  City? city;
  Category? category;
  SubCategory? subCategory;
  bool? isLiked;

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
        this.isLiked});

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
    user = json['user'] != null ? new UserV.fromJson(json['user']) : null;
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

class Garages {
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
  UserV? user;
  Country? country;
  State? state;
  City? city;
  List<Images>? images;
  bool? isLiked;

  Garages(
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
        this.isLiked});

  Garages.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new UserV.fromJson(json['user']) : null;
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

class VehicleTypes {
  String? carTypeId;
  String? image;
  String? title;

  VehicleTypes({this.carTypeId, this.image, this.title});

  VehicleTypes.fromJson(Map<String, dynamic> json) {
    carTypeId = json['carTypeId'];
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carTypeId'] = this.carTypeId;
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}
