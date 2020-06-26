import 'package:flutter/material.dart';
import 'package:orderntc/ui/styles/textstyle.dart';
import 'package:orderntc/ui/views/masters/barang_page.dart';
import 'package:orderntc/ui/views/masters/order_page.dart';
import 'package:orderntc/ui/views/masters/pelanggan_page.dart';
import 'package:orderntc/ui/views/masters/rekap_order_page.dart';
import 'package:orderntc/ui/views/masters/sales_page.dart';

class MasterView extends StatefulWidget {
  @override
  _MasterViewState createState() => _MasterViewState();
}

class _MasterViewState extends State<MasterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: <Widget>[
        GestureDetector(
          child: Container(
            color: Colors.indigo[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.storage,
                  size: MediaQuery.of(context).size.width / 7,
                ),
                Text('Barang', style: latoBold)
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BarangView()));
          },
        ),
        GestureDetector(
          child: Container(
            color: Colors.indigo[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  size: MediaQuery.of(context).size.width / 7,
                ),
                Text('Pelanggan', style: latoBold)
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PelangganView()));
          },
        ),
        GestureDetector(
          child: Container(
            color: Colors.indigo[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.people,
                  size: MediaQuery.of(context).size.width / 7,
                ),
                Text('Sales', style: latoBold)
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SalesView()));
          },
        ),
        GestureDetector(
          child: Container(
            color: Colors.indigo[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  size: MediaQuery.of(context).size.width / 7,
                ),
                Text('Order', style: latoBold)
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OrderView()));
          },
        ),
        GestureDetector(
          child: Container(
            color: Colors.indigo[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.store_mall_directory,
                  size: MediaQuery.of(context).size.width / 7,
                ),
                Text('Rekap Order', style: latoBold)
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RekapOrderView()));
          },
        ),
      ],
    ));
  }
}
