import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_movies/modules/movie/movie_model.dart';
import 'package:intl/intl.dart';

import '../order/order_provider.dart' as op;

class OrderItem extends StatefulWidget {
  final op.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: min(widget.order.movies.length * 20.0 + 50, 100),
              child: ListView(
                children: widget.order.movies
                    .map((movie) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              movie.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${movie.quantity}x \$${movie.price}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            )
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
