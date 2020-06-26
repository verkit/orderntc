import 'package:flutter/material.dart';
import 'package:orderntc/models/order.dart';
import 'package:orderntc/services/order_service.dart';
import 'package:orderntc/ui/styles/textstyle.dart';
import 'package:orderntc/ui/views/orders/form_order.dart';

class OrderNumberView extends StatefulWidget {
  OrderNumberView({Key key, this.nomor}) : super(key: key);
  final String nomor;

  @override
  _OrderNumberViewState createState() => _OrderNumberViewState();
}

class _OrderNumberViewState extends State<OrderNumberView> {
  OrderService service;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    service = OrderService();
    super.initState();
  }

  _navigateToForm(BuildContext context, Order data) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormOrder(order: data)));
    setState(() {
      service = OrderService();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Data Order')),
        body: SafeArea(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: getOrdersWidget())));
  }

  Widget getOrdersWidget() {
    return FutureBuilder(
      future: service.getDataByNomor(widget.nomor),
      builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
        return getOrderCardWidget(snapshot);
      },
    );
  }

  Widget getOrderCardWidget(AsyncSnapshot<List<Order>> snapshot) {
    if (snapshot.hasError) {
      return Center(
        child:
            Text("Something wrong with message: ${snapshot.error.toString()}"),
      );
    } else if (snapshot.connectionState == ConnectionState.done) {
      List<Order> data = snapshot.data;
      return _buildListView(data);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildListView(List<Order> pelanggan) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1, color: Colors.black38),
      itemBuilder: (context, index) {
        Order data = pelanggan[index];
        return ListTile(
          // leading: Icon(Icons.input),
          title: Text(
            data.namaBarang,
            style: listtileTitle,
          ),
          subtitle: Text("${data.qty} ${data.satuan}", style: latoSubtitle),
          trailing: GestureDetector(
            child: Icon(Icons.delete),
            onTap: () {
              _showMyDialog(data);
            },
          ),
          onTap: () {
            _navigateToForm(context, data);
          },
        );
      },
      itemCount: pelanggan.length >= 50 ? 50 : pelanggan.length,
    );
  }

  Future<void> _showMyDialog(Order order) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Yakin menghapus',
                  style: latoTitle,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "${order.namaBarang}?",
                  style: latoSubtitle,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Iya',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                service.deleteData(id: order.id);
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 1000),
                    content: Text("Berhasil menghapus data")));
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
