class PostModel {
  String? title;
  String? body;
  int? userId;
  int? id;

  PostModel({this.title, this.body, this.userId, this.id});

  PostModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = this.title;
    data['body'] = this.body;
    data['userId'] = this.userId;
    data['id'] = this.id;
    return data;
  }
}
