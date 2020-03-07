import 'package:json_annotation/json_annotation.dart';
import 'dart:math';

@JsonSerializable()
class Groups {
  List<Group> admin;
  List<Group> member;

  Groups(this.admin, this.member);

  Groups.fromJson(Map<String, dynamic> json)
      : admin =
            json['admin'].map<Group>((ad) => Group.fromJson(ad, true)).toList(),
        member = json['member']
            .map<Group>((mb) => Group.fromJson(mb, false))
            .toList();
}

class Group {
  String id, name, description, image;
  bool isAdmin;

  Group(this.id, this.name, this.description, this.isAdmin, this.image);

  Group.fromJson(Map<String, dynamic> json, bool isAdmin)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        isAdmin = isAdmin,
        image = _getRandomImage(isAdmin);
}

String _genRandomNumber(int min, int max) {
  Random random = new Random();
  int num = min + random.nextInt(max - min);
  return num.toString();
}

String _getRandomImage(bool isAdmin) {
  String type = isAdmin ? "admin" : "member";
  return "assets/$type/sushi-${_genRandomNumber(1, 5)}.jpg";
}
