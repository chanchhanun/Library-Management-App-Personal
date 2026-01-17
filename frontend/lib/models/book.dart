class Book {
  int? id;
  String? title;
  String? isbn;
  String? publishedDate;
  int? totalCopies;
  int? availableCopies;
  String? description;
  String? createdAt;
  String? image;
  String? status;
  AuthorDetail? authorDetail;
  String? authorName;
  int? category;

  Book(
      {this.id,
      this.title,
      this.isbn,
      this.publishedDate,
      this.totalCopies,
      this.availableCopies,
      this.description,
      this.createdAt,
      this.image,
      this.status,
      this.authorDetail,
      this.authorName,
      this.category});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isbn = json['isbn'];
    publishedDate = json['published_date'];
    totalCopies = json['total_copies'];
    availableCopies = json['available_copies'];
    description = json['description'];
    createdAt = json['created_at'];
    image = json['image'];
    status = json['status'];
    authorDetail = json['author_detail'] != null
        ? new AuthorDetail.fromJson(json['author_detail'])
        : null;
    authorName = json['author_name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['isbn'] = this.isbn;
    data['published_date'] = this.publishedDate;
    data['total_copies'] = this.totalCopies;
    data['available_copies'] = this.availableCopies;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['image'] = this.image;
    data['status'] = this.status;
    if (this.authorDetail != null) {
      data['author_detail'] = this.authorDetail!.toJson();
    }
    data['author_name'] = this.authorName;
    data['category'] = this.category;
    return data;
  }
}

class AuthorDetail {
  int? id;
  String? name;
  String? bio;
  String? createdAt;

  AuthorDetail({this.id, this.name, this.bio, this.createdAt});

  AuthorDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['created_at'] = this.createdAt;
    return data;
  }
}
