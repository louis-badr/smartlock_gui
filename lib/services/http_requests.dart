import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartlock_gui/models/inventory_models.dart';

const String baseURL = "https://dvic.devinci.fr/smart_inventory/api";

class ApiService {
  Future<List<CategoryModel>?> getCategories(int? category_id) async {
    var client = http.Client();
    var uri;
    if (category_id != null) {
      uri = Uri.parse('$baseURL/categories/subcategories/$category_id/');
    } else {
      uri = Uri.parse('$baseURL/categories/root/');
    }

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = utf8.decode(response.bodyBytes);
      return categoryModelFromJson(json);
    } else {
      print(response.statusCode);
    }
  }

  Future<List<ItemModel>?> getItems(int category_id) async {
    var client = http.Client();
    var uri;
    if (category_id != null) {
      uri = Uri.parse('$baseURL/categories/$category_id/items/');
    }

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = utf8.decode(response.bodyBytes);
      return itemModelFromJson(json);
    } else {
      print(response.statusCode);
    }
  }
}
