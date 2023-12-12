class CarDropDownModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  CarDropDownModel({this.statusCode, this.isSuccess, this.data});

  CarDropDownModel.fromJson(Map<String, dynamic> json) {
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
  List<CarMakers>? carMakers;
  List<CarTypes>? carTypes;
  List<CarConditions>? carConditions;
  List<CarFuelType>? carFuelType;
  List<CarGearBox>? carGearBox;
  List<CarColor>? carColor;
  List<CarEngineSize>? carEngineSize;
  List<CarCountries>? countries;
  List<WhenToStart>? whenToStart;

  Data(
      {this.carMakers,
        this.carTypes,
        this.carConditions,
        this.carFuelType,
        this.carGearBox,
        this.carColor,
        this.carEngineSize,
        this.countries,
        this.whenToStart});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['carMakers'] != null) {
      carMakers = <CarMakers>[];
      json['carMakers'].forEach((v) {
        carMakers!.add(new CarMakers.fromJson(v));
      });
    }
    if (json['carTypes'] != null) {
      carTypes = <CarTypes>[];
      json['carTypes'].forEach((v) {
        carTypes!.add(new CarTypes.fromJson(v));
      });
    }
    if (json['carConditions'] != null) {
      carConditions = <CarConditions>[];
      json['carConditions'].forEach((v) {
        carConditions!.add(new CarConditions.fromJson(v));
      });
    }
    if (json['carFuelType'] != null) {
      carFuelType = <CarFuelType>[];
      json['carFuelType'].forEach((v) {
        carFuelType!.add(new CarFuelType.fromJson(v));
      });
    }
    if (json['carGearBox'] != null) {
      carGearBox = <CarGearBox>[];
      json['carGearBox'].forEach((v) {
        carGearBox!.add(new CarGearBox.fromJson(v));
      });
    }
    if (json['carColor'] != null) {
      carColor = <CarColor>[];
      json['carColor'].forEach((v) {
        carColor!.add(new CarColor.fromJson(v));
      });
    }
    if (json['carEngineSize'] != null) {
      carEngineSize = <CarEngineSize>[];
      json['carEngineSize'].forEach((v) {
        carEngineSize!.add(new CarEngineSize.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <CarCountries>[];
      json['countries'].forEach((v) {
        countries!.add(new CarCountries.fromJson(v));
      });
    }
    if (json['whenToStart'] != null) {
      whenToStart = <WhenToStart>[];
      json['whenToStart'].forEach((v) {
        whenToStart!.add(new WhenToStart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carMakers != null) {
      data['carMakers'] = this.carMakers!.map((v) => v.toJson()).toList();
    }
    if (this.carTypes != null) {
      data['carTypes'] = this.carTypes!.map((v) => v.toJson()).toList();
    }
    if (this.carConditions != null) {
      data['carConditions'] =
          this.carConditions!.map((v) => v.toJson()).toList();
    }
    if (this.carFuelType != null) {
      data['carFuelType'] = this.carFuelType!.map((v) => v.toJson()).toList();
    }
    if (this.carGearBox != null) {
      data['carGearBox'] = this.carGearBox!.map((v) => v.toJson()).toList();
    }
    if (this.carColor != null) {
      data['carColor'] = this.carColor!.map((v) => v.toJson()).toList();
    }
    if (this.carEngineSize != null) {
      data['carEngineSize'] =
          this.carEngineSize!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.whenToStart != null) {
      data['whenToStart'] = this.whenToStart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarMakers {
  String? carMakerId;
  String? title;

  CarMakers({this.carMakerId, this.title});

  CarMakers.fromJson(Map<String, dynamic> json) {
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

class CarTypes {
  String? carTypeId;
  String? title;

  CarTypes({this.carTypeId, this.title});

  CarTypes.fromJson(Map<String, dynamic> json) {
    carTypeId = json['carTypeId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carTypeId'] = this.carTypeId;
    data['title'] = this.title;
    return data;
  }
}

class CarConditions {
  String? carConditionId;
  String? title;

  CarConditions({this.carConditionId, this.title});

  CarConditions.fromJson(Map<String, dynamic> json) {
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

class CarFuelType {
  String? carFuelTypeId;
  String? title;

  CarFuelType({this.carFuelTypeId, this.title});

  CarFuelType.fromJson(Map<String, dynamic> json) {
    carFuelTypeId = json['carFuelTypeId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carFuelTypeId'] = this.carFuelTypeId;
    data['title'] = this.title;
    return data;
  }
}

class CarGearBox {
  String? carGearBoxId;
  String? title;

  CarGearBox({this.carGearBoxId, this.title});

  CarGearBox.fromJson(Map<String, dynamic> json) {
    carGearBoxId = json['carGearBoxId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carGearBoxId'] = this.carGearBoxId;
    data['title'] = this.title;
    return data;
  }
}

class CarColor {
  String? carColorId;
  String? title;

  CarColor({this.carColorId, this.title});

  CarColor.fromJson(Map<String, dynamic> json) {
    carColorId = json['carColorId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carColorId'] = this.carColorId;
    data['title'] = this.title;
    return data;
  }
}

class CarEngineSize {
  String? carEngineSizeId;
  String? title;

  CarEngineSize({this.carEngineSizeId, this.title});

  CarEngineSize.fromJson(Map<String, dynamic> json) {
    carEngineSizeId = json['carEngineSizeId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carEngineSizeId'] = this.carEngineSizeId;
    data['title'] = this.title;
    return data;
  }
}

class CarCountries {
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

  CarCountries(
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

  CarCountries.fromJson(Map<String, dynamic> json) {
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

class WhenToStart {
  String? whenToStartId;
  String? title;

  WhenToStart({this.whenToStartId, this.title});

  WhenToStart.fromJson(Map<String, dynamic> json) {
    whenToStartId = json['whenToStartId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whenToStartId'] = this.whenToStartId;
    data['title'] = this.title;
    return data;
  }
}