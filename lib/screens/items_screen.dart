import 'package:flutter/material.dart';
import 'package:smartlock_gui/models/inventory_models.dart';
import 'package:smartlock_gui/services/http_requests.dart';

class ItemsScreen extends StatefulWidget {
  //  items parent category's id
  int category_id;
  ItemsScreen(this.category_id);
  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  // list of items fetched from the database
  List<ItemModel>? items;
  // the widgets of the list are visible when the data has been loaded
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getItemsData();
  }

  getItemsData() async {
    items = await ApiService().getItems(widget.category_id);
    if (items != null) {
      // sort by item title alphabetical order
      items!.sort((a, b) => a.title.compareTo(b.title));
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: items?.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(items![index].title),
                trailing: IconButton(
                  onPressed: () {
                    print("Notify");
                  },
                  icon: Icon(Icons.shopping_cart_rounded),
                ),
                leading: IconButton(
                    onPressed: () {
                      print("${items![index].title} info");
                    },
                    icon: const Icon(Icons.info_outline_rounded)),
              ),
            );
          },
        ),
        replacement: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
