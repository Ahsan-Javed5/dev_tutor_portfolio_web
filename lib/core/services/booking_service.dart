import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingService {
  static const apiUrl =
      "https://script.google.com/macros/s/AKfycbwRNcMAvX7taTwDpKOzi-ztWTdXXZwACeWFBggHniio02KvMqIXt7wnVboowvTdgHzz/exec";

  static Future<Map<String, dynamic>> submit(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }
}
