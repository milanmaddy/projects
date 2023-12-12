class staticTYPEModel {
  String? type;

  staticTYPEModel({this.type});

  staticTYPEModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}