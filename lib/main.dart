import 'package:crystal_app/long_term_care_app.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'model/long_term_care_item_order.dart';
import 'redux/cart_reducer.dart';

void main() {
  final store = Store<List<LongTermCareItemOrder>>(cartReducer,
      initialState: <LongTermCareItemOrder>[]);

  runApp(LongTermCareApp(store: store));
}
