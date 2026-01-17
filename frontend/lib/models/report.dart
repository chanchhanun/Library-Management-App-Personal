class Report {
  int? totalBorrows;
  int? totalReturns;
  List<CurrentBorrow>? currentBorrow;

  Report({this.totalBorrows, this.totalReturns, this.currentBorrow});

  Report.fromJson(Map<String, dynamic> json) {
    totalBorrows = json['total_borrows'];
    totalReturns = json['total_returns'];
    if (json['current_borrow'] != null) {
      currentBorrow = <CurrentBorrow>[];
      json['current_borrow'].forEach((v) {
        currentBorrow!.add(new CurrentBorrow.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_borrows'] = this.totalBorrows;
    data['total_returns'] = this.totalReturns;
    if (this.currentBorrow != null) {
      data['current_borrow'] =
          this.currentBorrow!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory Report.empty() {
    return Report(
      totalBorrows: null,
      totalReturns: null,
      currentBorrow: null,
    );
  }
}

class CurrentBorrow {
  String? title;
  int? borrowCount;

  CurrentBorrow({this.title, this.borrowCount});

  CurrentBorrow.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    borrowCount = json['borrow_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['borrow_count'] = this.borrowCount;
    return data;
  }
}
