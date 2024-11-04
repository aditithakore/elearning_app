import 'dart:convert';

import 'package:elearning_app/models/userProfile.dart';
import 'package:elearning_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserService extends GetxService {
  UserProfile profile = UserProfile();
  Future<void> fetchUser() async {
    String? token = await Utils().getAuthToken();
    final response =
        await http.get(Uri.parse("http://localhost:3001/user/"), headers: {
      "Authorization": token ?? '',
    });
    if (response.statusCode == 200) {
      profile = UserProfile.fromJson(jsonDecode(response.body));
    }
  }
}
