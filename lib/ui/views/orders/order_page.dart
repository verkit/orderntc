import 'package:flutter/material.dart';
import 'package:orderntc/ui/views/orders/form_order.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Klik tanda + untuk tambah order"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormOrder()),
            );
          }),
    );
  }
}
