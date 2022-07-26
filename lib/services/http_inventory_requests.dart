import 'dart:convert';

import 'package:smartlock_gui/constants.dart';
import 'package:http/http.dart';
import 'package:smartlock_gui/models/inventory_models.dart';

Future<List<CategoryModel>?> getCategories(int? category_id) async {
  var client = Client();
  var uri;
  if (category_id != null) {
    uri = Uri.parse('$baseUrlSI/categories/subcategories/$category_id/');
  } else {
    uri = Uri.parse('$baseUrlSI/categories/root/');
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
  var client = Client();
  var uri;
  if (category_id != null) {
    uri = Uri.parse('$baseUrlSI/categories/$category_id/items/');
  }

  var response = await client.get(uri);
  if (response.statusCode == 200) {
    var json = utf8.decode(response.bodyBytes);
    return itemModelFromJson(json);
  } else {
    print(response.statusCode);
  }
}
