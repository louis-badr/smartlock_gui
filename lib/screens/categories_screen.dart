import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlock_gui/models/inventory_models.dart';
import 'package:smartlock_gui/screens/items_screen.dart';
import 'package:smartlock_gui/services/http_requests.dart';

class CategoriesScreen extends StatefulWidget {
  // if null the screen will list all the root categories, if not, the sub categories of the associated category
  int? category_id = null;
  CategoriesScreen({Key? key, this.category_id}) : super(key: key);
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // list of categories fetched from the database
  List<CategoryModel>? categories;
  // the widgets of the list are visible when the data has been loaded
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getCategoriesData();
  }

  getCategoriesData() async {
    categories = await ApiService().getCategories(widget.category_id);
    if (categories != null) {
      if (categories!.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemsScreen(widget.category_id!)),
        );
      } else {
        // sort by category title alphabetical order
        categories!.sort((a, b) => a.title.compareTo(b.title));
        categories!.insert(0, CategoryModel(title: "Others", id: 0));
        setState(
          () {
            isLoaded = true;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CATEGORIES"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Visibility(
          visible: isLoaded,
          child: Column(
            children: <Widget>[
              const Card(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categories?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(categories![index].title),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        leading: IconButton(
                            onPressed: () {
                              print("${categories![index].title} info");
                            },
                            icon: const Icon(Icons.info_outline_rounded)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoriesScreen(
                                    category_id: categories![index].id)),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          replacement: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
