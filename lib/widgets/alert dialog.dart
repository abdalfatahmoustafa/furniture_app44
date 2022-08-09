import 'package:flutter/material.dart';
import 'package:furniture_app/data/data.dart';
import 'package:furniture_app/models/item%20model.dart';
import 'package:furniture_app/providers/order%20provider.dart';
import 'package:provider/provider.dart';

showDialoge(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.all(20),
            content: Container(
                width: 50,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 6,
                    ),
                    Text(
                      "\nWait ...",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )),
          ));
}

showItemOptionsDialog(BuildContext context, String keyItem) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
          title: Text(keyItem),
          contentPadding: EdgeInsets.all(20),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            Consumer<OrderProvider>(
              builder:(context, value, child) =>  TextButton(
                  onPressed: () {
                    ItemModel item = ItemModel(
                        item: keyItem,
                        number:
                            value.numberOfSelectedItem,
                        price: items[keyItem][
                                value.selectedItemValue] *
                            value.numberOfSelectedItem,
                        size: value.selectedItemValue);
                    value.addToSelectedItems(item);
                    Navigator.pop(context);
                  },
                  child: Text("Add")),
            )
          ],
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile(
                  value: 1,
                  groupValue: context.watch<OrderProvider>().selectedItem,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    context
                        .read<OrderProvider>()
                        .chooseSizeOfSelectedItem(value as int, "Small");
                  },
                  title: Text("Small"),
                ),
                RadioListTile(
                  value: 2,
                  groupValue: context.watch<OrderProvider>().selectedItem,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    context
                        .read<OrderProvider>()
                        .chooseSizeOfSelectedItem(value as int, "Medium");
                  },
                  title: Text("Medium"),
                ),
                RadioListTile(
                  value: 3,
                  groupValue: context.watch<OrderProvider>().selectedItem,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    context
                        .read<OrderProvider>()
                        .chooseSizeOfSelectedItem(value as int, "Large");
                  },
                  title: Text("Large"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          context
                              .read<OrderProvider>()
                              .decrementNumberOfSelectedItem();
                        },
                        child: Icon(
                          Icons.remove,
                          size: 30,
                        )),
                    Chip(
                      labelPadding: EdgeInsets.all(5),
                      label: Text(
                          "${context.watch<OrderProvider>().numberOfSelectedItem}"),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<OrderProvider>()
                            .incrementNumberOfSelectedItem();
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )));
}
