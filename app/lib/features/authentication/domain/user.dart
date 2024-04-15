import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? token;

  @HiveField(2)
  String? email;

  @HiveField(3)
  bool? isVerified;

  User({this.id, this.token, this.email, this.isVerified});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    email = json['email'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    data['email'] = email;
    data['isVerified'] = isVerified;
    return data;
  }
}
