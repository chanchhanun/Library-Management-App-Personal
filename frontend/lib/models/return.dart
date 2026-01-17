class Return {
  final String bookTitle;
  final String returnDate;
  final double fine;

  Return({
    required this.bookTitle,
    required this.returnDate,
    required this.fine,
  });

  factory Return.fromJson(Map<String, dynamic> json) {
    return Return(
      bookTitle: json['book_title'],
      returnDate: json['return_date'],
      fine: (json['fine'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'book_title': bookTitle,
      'return_date': returnDate,
      'fine': fine,
    };
  }

  bool get isLate => fine > 0;

  factory Return.empty() {
    return Return(
      bookTitle: '',
      returnDate: '',
      fine: 0.0,
    );
  }
}
