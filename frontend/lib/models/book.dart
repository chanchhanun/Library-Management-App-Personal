class Book {
  int? id;
  String? title;
  Author? author;
  String? authorName;
  String? isbn;
  String? publishedDate;
  int? totalCopies;
  int? availableCopies;
  String? description;
  String? createdAt;
  int? category;
  String? image;
  String? status;

  Book(
      {this.id,
      this.title,
      this.author,
      this.authorName,
      this.isbn,
      this.publishedDate,
      this.totalCopies,
      this.availableCopies,
      this.description,
      this.createdAt,
      this.category,
      this.image,
      this.status});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    authorName = json['author_name'];
    isbn = json['isbn'];
    publishedDate = json['published_date'];
    totalCopies = json['total_copies'];
    availableCopies = json['available_copies'];
    description = json['description'];
    createdAt = json['created_at'];
    category = json['category'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['author_name'] = this.authorName;
    data['isbn'] = this.isbn;
    data['published_date'] = this.publishedDate;
    data['total_copies'] = this.totalCopies;
    data['available_copies'] = this.availableCopies;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['category'] = this.category;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }

  factory Book.empty() {
    return Book(
        id: null,
        title: null,
        author: null,
        authorName: null,
        isbn: null,
        publishedDate: null,
        totalCopies: null,
        availableCopies: null,
        description: null,
        createdAt: null,
        category: null,
        image: null,
        status: null);
  }
}

class Author {
  int? id;
  String? name;
  String? bio;
  String? createdAt;

  Author({this.id, this.name, this.bio, this.createdAt});

  Author.fromJson(Map<String, dynamic> json) {
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
