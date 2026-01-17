class BorrowHistory {
  int? id;
  User? user;
  Book? book;
  String? borrowDate;
  String? returnDate;
  String? status;
  String? createdAt;

  BorrowHistory(
      {this.id,
      this.user,
      this.book,
      this.borrowDate,
      this.returnDate,
      this.status,
      this.createdAt});

  BorrowHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    borrowDate = json['borrow_date'];
    returnDate = json['return_date'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.book != null) {
      data['book'] = this.book!.toJson();
    }
    data['borrow_date'] = this.borrowDate;
    data['return_date'] = this.returnDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class User {
  int? id;
  String? username;

  User({this.id, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}

class Book {
  int? id;
  String? title;
  String? image;
  String? status;

  Book({this.id, this.title, this.image, this.status});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
