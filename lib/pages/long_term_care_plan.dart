import 'package:crystal_app/long_term_care_item_edit.dart';
import 'package:crystal_app/model/long_term_care_item.dart';
import 'package:crystal_app/model/long_term_care_item_order.dart';
import 'package:crystal_app/redux/cart_del_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LongTermCarePlanPage extends StatelessWidget {
  final Store<List<LongTermCareItemOrder>> store;

  const LongTermCarePlanPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    bool isLargeScreen;
    double containerWidth = double.infinity;

    Widget createMobileView(List<LongTermCareItemOrder> items) {
      int totalPrice = 0;
      for (var item in items) {
        totalPrice += item.price * item.amount;
      }

      return ListView(
        children: [
          Column(
            children: items
                .map(
                  (e) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                e.id + ' ' + e.name,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  '金額',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Text(
                                '\$' + e.price.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  '數量',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Text(
                                e.amount.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '\$' + (e.price * e.amount).toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Divider(
            color: Colors.teal.shade100,
            thickness: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.payment),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('計畫金額'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '\$' + totalPrice.toString(),
                  style: const TextStyle(fontSize: 24, color: Colors.red),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget createTabletView(List<LongTermCareItemOrder> items) {
      int totalPrice = 0;
      for (var item in items) {
        totalPrice += item.price * item.amount;
      }

      return ListView(
        children: [
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('編號')),
                DataColumn(label: Text('服務項目')),
                DataColumn(label: Text('金額')),
                DataColumn(label: Text('服務數量')),
                DataColumn(label: Text('小計')),
                DataColumn(label: Text('操作')),
              ],
              rows: items
                  .map(
                    (item) => DataRow(
                      cells: [
                        DataCell(Text(item.id)),
                        DataCell(Text(item.name)),
                        DataCell(Text('\$' + item.price.toString())),
                        DataCell(Text(item.amount.toString())),
                        DataCell(Text('\$' + (item.price * item.amount).toString())),
                        DataCell(Container(
                          width: 200,
                          child: Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LongTermCareItemEditPage(
                                              store: store, id: item.id, amount: item.amount)));
                                },
                                label: const Text('編輯'),
                                icon: const Icon(Icons.edit, size: 14),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  store.dispatch(CartDelAction(item.id));
                                },
                                label: const Text('刪除'),
                                icon: const Icon(Icons.delete, size: 14),
                                style: ElevatedButton.styleFrom(primary: Colors.red),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(
            color: Colors.blue,
            thickness: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.payment),
              ),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('計畫金額'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '\$' + totalPrice.toString(),
                  style: const TextStyle(fontSize: 24, color: Colors.red),
                ),
              ),
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.long_trem_care_plan_title),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
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
            child: StoreConnector<List<LongTermCareItemOrder>, List<LongTermCareItemOrder>>(
              converter: (store) => store.state,
              builder: (context, items) {
                if (isLargeScreen) {
                  return createTabletView(items);
                } else {
                  return createMobileView(items);
                }
              },
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LongTermCareItemEditPage(store: store, id: '', amount: 0)));
        },
      ),
    );
  }
}
