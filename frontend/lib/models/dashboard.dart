class Dashboard {
  int? totalBooks;
  int? borrowedBooks;
  int? overdueBooks;
  int? totalUsers;

  Dashboard(
      {this.totalBooks,
      this.borrowedBooks,
      this.overdueBooks,
      this.totalUsers});

  Dashboard.fromJson(Map<String, dynamic> json) {
    totalBooks = json['total_books'];
    borrowedBooks = json['borrowed_books'];
    overdueBooks = json['overdue_books'];
    totalUsers = json['total_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_books'] = this.totalBooks;
    data['borrowed_books'] = this.borrowedBooks;
    data['overdue_books'] = this.overdueBooks;
    data['total_users'] = this.totalUsers;
    return data;
  }

  factory Dashboard.empty() {
    return Dashboard(
      totalBooks: 0,
      borrowedBooks: 0,
      overdueBooks: 0,
      totalUsers: 0,
    );
  }

  @override
  String toString() {
    return Dashboard(
      totalBooks: totalBooks,
      borrowedBooks: borrowedBooks,
      overdueBooks: overdueBooks,
      totalUsers: totalUsers,
    ).toString();
  }
}
