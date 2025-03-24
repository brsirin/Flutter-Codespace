import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  // Kullanıcı girişi
  static Future<int?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      body: {"username": username, "password": password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["user_id"]; // Giriş başarılıysa user_id döndür
    } else {
      return null; // Başarısız giriş
    }
  }

  // Tüm kampanyaları çek
  static Future<List<Map<String, dynamic>>> fetchCampaigns() async {
    final response = await http.get(Uri.parse("$baseUrl/mobile/campaigns"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception("Kampanyalar yüklenemedi");
    }
  }

  // Kullanıcının favori kampanyalarını çek
  static Future<List<Map<String, dynamic>>> fetchFavorites(int userId) async {
    final response =
        await http.get(Uri.parse("$baseUrl/mobile/users/$userId/favorites"));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception("Favoriler yüklenemedi");
    }
  }
}