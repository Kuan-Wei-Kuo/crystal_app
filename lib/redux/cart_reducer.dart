import 'package:crystal_app/model/long_term_care_item_order.dart';
import 'package:crystal_app/redux/cart_del_action.dart';

import 'cart_add_action.dart';

List<LongTermCareItemOrder> cartReducer(List<LongTermCareItemOrder> orders, dynamic action) {
  if (action is CartAddAction) {
    orders.removeWhere((order) => order.id == action.order.id);
    return List.from(orders)..add(action.order);
  } else if (action is CartDelAction) {
    orders.removeWhere((order) => order.id == action.id);
  }
  return orders;
}
