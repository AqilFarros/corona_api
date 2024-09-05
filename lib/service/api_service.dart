import 'dart:convert';

import 'package:corona_api/config/config.dart';
import 'package:corona_api/model/hoax.dart';
import 'package:corona_api/model/hospital.dart';
import 'package:corona_api/model/news.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Hoax>?> getHoax() async {
    var url = Uri.parse("$baseURL/hoaxes");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => Hoax.fromJson(item)).toList();
    } else {
      print("Request gagal dengan status: ${response.statusCode}");
      return null;
    }
  }

  Future<List<Hospital>?> getHospital() async {
    var url = Uri.parse("$baseURL/hospitals");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => Hospital.fromJson(item)).toList();
    } else {
      print("Request gagal dengan status: ${response.statusCode}");
      return null;
    }
  }

  Future<List<News>?> getNews() async {
    var url = Uri.parse("$baseURL/news");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      print("Request gagal dengan status: ${response.statusCode}");
      return null;
    }
  }

  Future<Map?> getStat() async {
    var url = Uri.parse("$baseURL/stats");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else {
      print("Request gagal dengan status: ${response.statusCode}");
      return null;
    }
  }
}
