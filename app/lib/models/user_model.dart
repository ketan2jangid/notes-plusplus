class UserModel {
  String? id;
  String? email;
  bool? isVerified;
  List<String>? notes;

  UserModel({this.id, this.email, this.isVerified, this.notes});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    isVerified = json['isVerified'];
    notes = json['notes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['isVerified'] = this.isVerified;
    data['notes'] = this.notes;
    return data;
  }
}
