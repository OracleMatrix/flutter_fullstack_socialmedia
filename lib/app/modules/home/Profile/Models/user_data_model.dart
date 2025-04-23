import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  int? id;
  String? name;
  String? email;

  UserDataModel({this.id, this.name, this.email});

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      UserDataModel(id: json["id"], name: json["name"], email: json["email"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};
}
