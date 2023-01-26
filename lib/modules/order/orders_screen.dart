import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../order/order_provider.dart' show Orders;
import '../order/orderItem_widget.dart';
import '../../widgets/appDrawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersObj = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(ordersObj.orders[i]),
        itemCount: ordersObj.orders.length,
      ),
    );
  }
}
