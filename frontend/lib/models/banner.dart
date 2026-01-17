class Banner {
  int? id;
  String? title;
  String? image;
  String? createdAt;

  Banner({this.id, this.title, this.image, this.createdAt});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
