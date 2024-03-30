class NoteModel {
  String? id;
  String? title;
  String? body;
  String? updatedAt;

  NoteModel({this.id, this.title, this.body, this.updatedAt});

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    body = json['body'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
