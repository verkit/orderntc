import 'package:flutter/material.dart';
import 'package:orderntc/models/order.dart';
import 'package:orderntc/services/order_service.dart';
import 'package:orderntc/ui/styles/textstyle.dart';
import 'package:orderntc/ui/views/masters/order_number_page.dart';

class OrderView extends StatefulWidget {
  OrderView({Key key}) : super(key: key);
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  OrderService service;
  final _formKey = GlobalKey<FormState>();
  var order = "";
  var _tanggal = DateTime.now().toString().substring(0, 10);

  @override
  void initState() {
    service = OrderService();
    super.initState();
  }

  _navigateToDetailPage(BuildContext context, Order data) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => OrderNumberView(
                  nomor: data.nomorOrder,
                )));
    setState(() {
      service = OrderService();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Data Order')),
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (value) {
                      setState(() {
                        order = value;
                      });
                    },
                    decoration: new InputDecoration(
                      labelText: "Cari order",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(),
                      ),
                    ),
                  )),
              getOrdersWidget(_tanggal, order: order)
            ],
          ),
        )));
  }

  Widget getOrdersWidget(String tanggal, {String order}) {
    return FutureBuilder(
      future: service.getDataOrderHari(tanggal, noorder: order),
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

  Widget _buildListView(List<Order> order) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1, color: Colors.black38),
      itemBuilder: (context, index) {
        Order data = order[index];
        return ListTile(
          // leading: Icon(Icons.input),
          title: Text(
            data.nomorOrder,
            style: listtileTitle,
          ),
          subtitle: Text(data.namaPelanggan, style: latoSubtitle),
          onTap: () {
            _navigateToDetailPage(context, data);
          },
        );
      },
      itemCount: order.length >= 50 ? 50 : order.length,
    );
  }
}
