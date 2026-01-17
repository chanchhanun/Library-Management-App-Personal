import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/app_const.dart';
import '../../models/member.dart';

class MemberApi {
  final baseUrl = AppConst.baseUrl;

  // Members
  Future<List<Member>> getMembers() async {
    final response = await http.get(Uri.parse('$baseUrl/members/'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['results'];
      return body.map((dynamic item) => Member.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load members');
    }
  }

  Future<Member> createMember(Member member) async {
    final response = await http.post(
      Uri.parse('$baseUrl/members/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(member.toJson()),
    );
    if (response.statusCode == 201) {
      return Member.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create member');
    }
  }
}
