import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee_model.dart';

class ApiService {
  //Change this Url if your backend is runninng on another machine
  static const String baseUrl = "http://localhost:3000";

  Future<Employee> fetchLocation() async {
    final response = await http.get(Uri.parse('$baseUrl/location'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Employee.fromJson(jsonData);
    } else {
      throw Exception('Failed to load location data');
    }
  }
}
