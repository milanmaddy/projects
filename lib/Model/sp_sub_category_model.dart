class SparePartsSubCategoryModel {
  int? statusCode;
  bool? isSuccess;
  Data? data;

  SparePartsSubCategoryModel({this.statusCode, this.isSuccess, this.data});

  SparePartsSubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<SparePartSubCategories>? sparePartSubCategories;

  Data({this.sparePartSubCategories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sparePartSubCategories'] != null) {
      sparePartSubCategories = <SparePartSubCategories>[];
      json['sparePartSubCategories'].forEach((v) {
        sparePartSubCategories!.add(new SparePartSubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sparePartSubCategories != null) {
      data['sparePartSubCategories'] =
          this.sparePartSubCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SparePartSubCategories {
  String? sparePartSubCategoryId;
  String? title;

  SparePartSubCategories({this.sparePartSubCategoryId, this.title});

  SparePartSubCategories.fromJson(Map<String, dynamic> json) {
    sparePartSubCategoryId = json['sparePartSubCategoryId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sparePartSubCategoryId'] = this.sparePartSubCategoryId;
    data['title'] = this.title;
    return data;
  }
}