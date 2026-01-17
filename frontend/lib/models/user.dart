class User {
  int? id;
  String? username;
  String? email;
  bool isStaff = false;

  User({this.id, this.username, this.email, this.isStaff = false});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    isStaff = json['is_staff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['is_staff'] = this.isStaff;
    return data;
  }

  factory User.empty() {
    return User(id: 0, username: '', email: '', isStaff: true);
  }

  @override
  String toString() {
    return User(id: id, username: username, email: email, isStaff: isStaff)
        .toJson()
        .toString();
  }
}
