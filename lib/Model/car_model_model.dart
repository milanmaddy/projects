class CarModelModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  CarModelModel({this.statusCode, this.isSuccess, this.data});

  CarModelModel.fromJson(Map<String, dynamic> json) {
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
  List<CarModels>? carModels;

  Data({this.carModels});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['carModels'] != null) {
      carModels = <CarModels>[];
      json['carModels'].forEach((v) {
        carModels!.add(new CarModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carModels != null) {
      data['carModels'] = this.carModels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarModels {
  String? carModelId;
  String? title;

  CarModels({this.carModelId, this.title});

  CarModels.fromJson(Map<String, dynamic> json) {
    carModelId = json['carModelId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carModelId'] = this.carModelId;
    data['title'] = this.title;
    return data;
  }
}