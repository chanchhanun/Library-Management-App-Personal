class Borrow {
  int? id;
  User? user;
  BookDetail? bookDetail;
  String? borrowDate;
  int? borrowDays;
  String? returnDate;

  Borrow(
      {this.id,
      this.user,
      this.bookDetail,
      this.borrowDate,
      this.borrowDays,
      this.returnDate});

  Borrow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    bookDetail = json['book_detail'] != null
        ? new BookDetail.fromJson(json['book_detail'])
        : null;
    borrowDate = json['borrow_date'];
    borrowDays = json['borrow_days'];
    returnDate = json['return_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.bookDetail != null) {
      data['book_detail'] = this.bookDetail!.toJson();
    }
    data['borrow_date'] = this.borrowDate;
    data['borrow_days'] = this.borrowDays;
    data['return_date'] = this.returnDate;
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

class BookDetail {
  int? id;
  String? title;
  String? image;
  String? status;

  BookDetail({this.id, this.title, this.image, this.status});

  BookDetail.fromJson(Map<String, dynamic> json) {
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
