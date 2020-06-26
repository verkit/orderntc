import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:orderntc/models/order.dart';
import 'package:intl/intl.dart';
import 'package:orderntc/services/order_service.dart';
import 'package:orderntc/services/sales_service.dart';
import 'package:orderntc/ui/styles/textstyle.dart';
import 'package:orderntc/ui/views/masters/order_number_page.dart';

class RekapOrderView extends StatefulWidget {
  RekapOrderView({Key key}) : super(key: key);
  @override
  _RekapOrderViewState createState() => _RekapOrderViewState();
}

class _RekapOrderViewState extends State<RekapOrderView> {
  OrderService _service;
  final SalesService _salesService = SalesService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _salesController = TextEditingController();
  TextEditingController _tglawalController = TextEditingController();
  TextEditingController _tglakhirController = TextEditingController();
  var _kodeSales;
  bool search;

  @override
  void initState() {
    search = false;
    _service = OrderService();
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
      _service = OrderService();
    });
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    return Scaffold(
        appBar: AppBar(title: Text('Rekap Order')),
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: this._salesController,
                            decoration: new InputDecoration(
                              labelText: "Sales",
                              border: new OutlineInputBorder(
                                borderSide: new BorderSide(),
                              ),
                            )),
                        suggestionsCallback: (pattern) async {
                          return await _salesService.getSales(query: pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion.namaSales()),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          this._salesController.text = suggestion.namaSales();
                          this._kodeSales = suggestion.kodeSales();
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                      ),
                      Divider(),
                      DateTimeField(
                        controller: _tglawalController,
                        decoration: new InputDecoration(
                          labelText: "Tanggal awal",
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(),
                          ),
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                      Divider(),
                      DateTimeField(
                        controller: _tglakhirController,
                        decoration: new InputDecoration(
                          labelText: "Tanggal akhir",
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(),
                          ),
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                      Divider(),
                      RaisedButton(
                          onPressed: () {
                            setState(() {
                              search = true;
                            });
                          },
                          child: Text("Cari"))
                    ],
                  )),
              search == false
                  ? Container()
                  : getOrdersWidget(
                      sales: _kodeSales,
                      tglakhir: _tglakhirController.text,
                      tglawal: _tglawalController.text)
            ],
          ),
        )));
  }

  Widget getOrdersWidget({String sales, String tglakhir, String tglawal}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text("Hasil pencarian"),
        ),
        FutureBuilder(
          future: _service.getDataBySales(
              sales: sales, tglakhir: tglakhir, tglawal: tglawal),
          builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
            return getOrderCardWidget(snapshot);
          },
        ),
      ],
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
          subtitle: Text(data.namaSales, style: latoSubtitle),
          onTap: () {
            _navigateToDetailPage(context, data);
          },
        );
      },
      itemCount: order.length >= 50 ? 50 : order.length,
    );
  }
}
