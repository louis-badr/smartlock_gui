import 'package:flutter/material.dart';
import 'package:smartlock_gui/models/inventory_models.dart';
import 'package:smartlock_gui/screens/empty_category_screen.dart';
import 'package:smartlock_gui/services/http_inventory_requests.dart';

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
    items = await getItems(widget.category_id);
    if (items != null) {
      if (items!.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmptyCategoryScreen()),
        );
      } else {
        // sort by item title alphabetical order
        items!.sort((a, b) => a.title.compareTo(b.title));
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
        title: const Text("ITEMS"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Visibility(
          visible: isLoaded,
          child: ListView.builder(
            itemCount: items?.length,
            itemBuilder: (context, index) {
              return Card(
                child: ExpansionTile(
                  title: Text(items![index].title),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(text: "Description\n\n"),
                                  TextSpan(
                                      text: items![index].description,
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 25, right: 10),
                            child: IconButton(
                              color: Colors.redAccent,
                              onPressed: () {
                                print("Notify");
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                      "Notify Low Stock",
                                    ),
                                    content: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text:
                                                    "Do you want to notify low stock for\n"),
                                            TextSpan(
                                                text: items![index].title,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const TextSpan(
                                                text:
                                                    " ?\n This action will create an order request.")
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextButton(
                                          onPressed: () {
                                            print("Request Order");
                                            // http post request
                                          },
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  barrierDismissible: true,
                                );
                              },
                              icon: const Icon(Icons.shopping_cart_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          replacement: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
