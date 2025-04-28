import 'dart:convert';

import 'package:cours_flutter/crud/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static var client = http.Client();
  static String baseUrl = "https://67fcd8741f8b41c81687c200.mockapi.io/product";
  static var header = {"content-type": "application/json"};

  static Future<List<dynamic>> getAll() async {
    var url = Uri.parse(baseUrl);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Something wrong happened");
    }
  }

  static Future<dynamic> create(Product product) async {
    var url = Uri.parse(baseUrl);
    var response = await client.post(url,
        headers: header, body: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Something wrong happened");
    }
  }

  static Future<dynamic> update(Product product) async {
    var url = Uri.parse(baseUrl + "/" + product.id);
    var response = await client.put(url,
        headers: header, body: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Something wrong happened");
    }
  }

  static Future<void> delete(id) async {
    var url = Uri.parse(baseUrl + "/" + id);
    var response = await client.delete(url, headers: header);
    if (response.statusCode == 200) {
      print('Deleted successfuly');
    } else {
      throw Exception("Something wrong happened");
    }
  }
}
