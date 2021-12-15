import 'package:crystal_app/redux/cart_add_action.dart';
import 'package:crystal_app/redux/cart_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'model/long_term_care_item.dart';
import 'model/long_term_care_item_order.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LongTermCareItemEditPage extends StatefulWidget {
  final Store<List<LongTermCareItemOrder>> store;
  final String id;
  final int amount;

  const LongTermCareItemEditPage({Key? key, required this.store, required this.id, required this.amount})
      : super(key: key);

  @override
  State<LongTermCareItemEditPage> createState() => _LongTermCareItemEditPageState();
}

class _LongTermCareItemEditPageState extends State<LongTermCareItemEditPage> {
  final TextEditingController amountController = TextEditingController();

  List<LongTermCareItem> items = [];
  LongTermCareItem? dropdownValue = LongTermCareItem('', '', 0);

  bool isEdited = false;

  void loadItems() async {
    final String data = await rootBundle.loadString("long_term_care_item.json");
    final jsonResult = json.decode(data); //latest Dart
    setState(() {
      items = (jsonResult as List).map((data) => LongTermCareItem.fromJson(data)).toList();

      if (items.where((item) => item.id == widget.id).isNotEmpty) {
        dropdownValue = items.where((item) => item.id == widget.id).first;
      } else {
        dropdownValue = items[0];
      }
    });
  }

  @override
  void initState() {
    isEdited = widget.id != null && widget.id != '';
    amountController.text = widget.amount.toString();

    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen;
    double containerWidth = double.infinity;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Long-Term Care Item Edit"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          const heightSizedBox = SizedBox(height: 16);

          if (MediaQuery.of(context).size.width > 600) {
            isLargeScreen = true;
            containerWidth = MediaQuery.of(context).size.width * 0.6;
          } else {
            isLargeScreen = false;
            containerWidth = double.infinity;
          }

          return Center(
            widthFactor: double.infinity,
            child: Container(
              width: containerWidth,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  InputDecorator(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, top: 8, right: 10, bottom: 8),
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.bookmark),
                      labelText: '服務項目',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<LongTermCareItem>(
                        isExpanded: true,
                        hint: const Text('選擇照顧服務'),
                        value: dropdownValue,
                        onChanged: isEdited
                            ? null
                            : (LongTermCareItem? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                        items: items.map<DropdownMenuItem<LongTermCareItem>>((LongTermCareItem value) {
                          return DropdownMenuItem<LongTermCareItem>(
                            value: value,
                            child: Text(value.id + ' - ' + value.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  heightSizedBox,
                  TextField(
                    restorationId: 'price',
                    readOnly: true,
                    controller: TextEditingController(text: dropdownValue!.price.toString()),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.attach_money),
                      labelText: '價格',
                    ),
                  ),
                  heightSizedBox,
                  TextField(
                    controller: amountController,
                    restorationId: 'amount',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '請輸入數量',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.tag),
                      labelText: '數量',
                    ),
                  ),
                  heightSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.store.dispatch(CartAddAction(LongTermCareItemOrder(dropdownValue!.id,
                              dropdownValue!.name, dropdownValue!.price, int.parse(amountController.text))));
                          Navigator.pushNamed(context, "/long_term_care_plan");
                        },
                        child: const Text('確認'),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            textStyle: const TextStyle(fontSize: 14)),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
