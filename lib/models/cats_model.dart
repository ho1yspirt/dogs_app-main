class CatsModel {
  String? file;

  CatsModel({this.file});

  CatsModel.fromJson(Map<String, dynamic> json) {
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['file'] = file;
    return data;
  }
}
