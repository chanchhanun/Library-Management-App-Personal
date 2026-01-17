class Member {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final DateTime membershipDate;
  final bool isActive;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.membershipDate,
    required this.isActive,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      membershipDate: DateTime.parse(json['membership_date']),
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'is_active': isActive,
    };
  }
}
