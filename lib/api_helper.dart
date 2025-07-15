import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static final ApiHelper _instance = ApiHelper._internal();
  factory ApiHelper() => _instance;
  ApiHelper._internal();

  final String _baseUrl = 'https://spring-itpm-api.onrender.com/api/users';

  Future<Map<String, dynamic>> registerUser({
    required String userid,
    required String password,
    required String name,
    required String email,
  }) async {
    final url = Uri.parse('$_baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userid': userid,
        'password': password,
        'name': name,
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to register user: \\${response.body}');
    }
  }
} 