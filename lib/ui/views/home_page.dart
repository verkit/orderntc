import 'package:flutter/material.dart';
import 'package:orderntc/ui/styles/theme.dart';
import 'package:orderntc/ui/views/masters/master_page.dart';
import 'package:orderntc/ui/views/orders/order_page.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    OrderPage(),
    MasterView()
  ];

  static List<BottomNavigationBarItem> _tabs(BuildContext context) => [
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Order'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            title: Text('Master'),
          ),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order NTC'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: _tabs(context),
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
