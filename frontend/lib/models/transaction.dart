class Transaction {
  final int id;
  final int book;
  final String? bookTitle;
  final int member;
  final String? memberName;
  final DateTime borrowDate;
  final DateTime dueDate;
  final DateTime? returnDate;
  final String status;
  final double fine;

  Transaction({
    required this.id,
    required this.book,
    this.bookTitle,
    required this.member,
    this.memberName,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
    required this.status,
    required this.fine,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      book: json['book'],
      bookTitle: json['book_title'],
      member: json['member'],
      memberName: json['member_name'],
      borrowDate: DateTime.parse(json['borrow_date']),
      dueDate: DateTime.parse(json['due_date']),
      returnDate: json['return_date'] != null
          ? DateTime.parse(json['return_date'])
          : null,
      status: json['status'],
      fine: double.parse(json['fine'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book': book,
      'member': member,
    };
  }
}
