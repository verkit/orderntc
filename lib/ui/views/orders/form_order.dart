import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:orderntc/models/order.dart';
import 'package:orderntc/services/barang_service.dart';
import 'package:orderntc/services/order_service.dart';
import 'package:orderntc/services/pelanggan_service.dart';
import 'package:orderntc/services/sales_service.dart';

class FormOrder extends StatefulWidget {
  FormOrder({Key key, this.order}) : super(key: key);
  final Order order;

  @override
  _FormOrderState createState() => _FormOrderState();
}

class _FormOrderState extends State<FormOrder> {
  final BarangService _barangService = BarangService();
  final SalesService _salesService = SalesService();
  final PelangganService _pelangganService = PelangganService();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _barangController = TextEditingController();
  final TextEditingController _salesController = TextEditingController();
  final TextEditingController _pelangganController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _satuanController = TextEditingController();

  var _sales,
      _kodesales,
      _harga,
      _pelanggan,
      _kodepelanggan,
      _barang,
      _kodebarang,
      _satuan,
      _qty,
      _jual1,
      _jual2,
      _jual3;
  int _order;

  var _date = DateTime.now().toString().substring(0, 10);
  var unique = DateFormat.y().format(DateTime.now()) +
      DateFormat.M().format(DateTime.now()) +
      DateFormat.d().format(DateTime.now()) +
      DateFormat.s().format(DateTime.now());

  int i = 1;

  void _clearSubmitForm() {
    _barangController.clear();
    _qtyController.clear();
    _hargaController.clear();
  }

  void _clearNewForm() {
    _salesController.clear();
    _qtyController.clear();
    _pelangganController.clear();
    _barangController.clear();
    _hargaController.clear();
  }

  @override
  void initState() {
    if (widget.order != null) {
      _salesController.text = widget.order.namaSales;
      _pelangganController.text = widget.order.namaPelanggan;
      _barangController.text = widget.order.namaBarang;
      _hargaController.text = widget.order.harga;
      _jual1 = widget.order.harga;
      _qtyController.text = widget.order.qty.toString();
      _satuanController.text = widget.order.satuan;
      _kodebarang = widget.order.kodeBarang;
      _kodepelanggan = widget.order.kodePelanggan;
      _kodesales = widget.order.kodeSales;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _order = int.parse(unique);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: widget.order == null
                ? Text('Tambah order')
                : Text('Edit order')),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  _pelangganForm(),
                  Divider(),
                  _salesForm(),
                  Divider(),
                  _barangForm(),
                  Divider(),
                  _hargaForm(),
                  Divider(),
                  _kuantitasForm(),
                  Divider(),
                  widget.order == null ? btnTambah() : btnEdit(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _barangForm() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._barangController,
          decoration: new InputDecoration(
            labelText: "Barang",
            border: new OutlineInputBorder(
              borderSide: new BorderSide(),
            ),
          )),
      suggestionsCallback: (pattern) async {
        return await _barangService.getBarang(query: pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.namaBarang()),
        );
      },
      onSuggestionSelected: (suggestion) {
        this._barangController.text = suggestion.namaBarang();
        this._kodebarang = suggestion.kodeBarang();
        this._satuanController.text = suggestion.satuanBarang();
        this._jual1 = suggestion.jual1();
        this._jual2 = suggestion.jual2();
        this._jual3 = suggestion.jual3();
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Barang harap diisi';
        }
        return null;
      },
      onSaved: (value) => this._barang = value,
    );
  }

  Widget _salesForm() {
    return TypeAheadFormField(
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
        this._kodesales = suggestion.kodeSales();
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Sales harap diisi';
        }
        return null;
      },
      onSaved: (value) => this._sales = value,
    );
  }

  Widget _pelangganForm() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._pelangganController,
          decoration: new InputDecoration(
            labelText: "Pelanggan",
            border: new OutlineInputBorder(
              borderSide: new BorderSide(),
            ),
          )),
      suggestionsCallback: (pattern) async {
        return await _pelangganService.getPelanggan(query: pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.namaPelanggan()),
        );
      },
      onSuggestionSelected: (suggestion) {
        this._pelangganController.text = suggestion.namaPelanggan();
        this._kodepelanggan = suggestion.kodePelanggan();
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Pelanggan harap diisi';
        }
        return null;
      },
      onSaved: (value) => this._pelanggan = value,
    );
  }

  Widget _hargaForm() {
    Future<List<String>> hargaSuggestion(String query) async {
      List<String> harga = List();
      harga.add(_jual1);
      if (widget.order == null) {
        harga.add(_jual2);
        harga.add(_jual3);
      }

      // harga.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
      return harga;
    }

    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._hargaController,
          decoration: new InputDecoration(
            labelText: "Harga",
            border: new OutlineInputBorder(
              borderSide: new BorderSide(),
            ),
          )),
      suggestionsCallback: (pattern) async {
        return await hargaSuggestion(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        this._hargaController.text = suggestion;
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Harga harap diisi';
        }
        return null;
      },
      onSaved: (value) => this._harga = value,
    );
  }

  Widget _kuantitasForm() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 8,
          child: TextFormField(
            controller: _qtyController,
            decoration: InputDecoration(
                labelText: "Kuantitas",
                border: new OutlineInputBorder(borderSide: new BorderSide())),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Kuantitas harap diisi';
              }
              return null;
            },
            onSaved: (val) => _qty = val,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
            flex: 1,
            child: TextFormField(
                controller: _satuanController,
                enabled: false,
                decoration: InputDecoration(
                  hintText: _satuanController.text,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onSaved: (val) => _satuan = val)),
      ],
    );
  }

  Widget btnTambah() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              i = 1;
              _order = _order + 1;
              _clearNewForm();
            },
            child: Text('Baru'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              if (_formKey.currentState.validate()) {
                this._formKey.currentState.save();

                final newOrder = Order(
                    harga: _harga,
                    kodeBarang: _kodebarang,
                    namaBarang: _barang,
                    kodePelanggan: _kodepelanggan,
                    namaPelanggan: _pelanggan,
                    kodeSales: _kodesales,
                    namaSales: _sales,
                    tanggal: _date,
                    nomorOrder: _order.toString(),
                    satuan: _satuan,
                    qty: int.parse(_qty));

                OrderService _orderService = OrderService();
                _orderService.postData(newOrder);

                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    duration: Duration(milliseconds: 1000),
                    content: Text("Sukses, input order ke $i")));

                _clearSubmitForm();

                this.i = i + 1;
                if (i > 30) {
                  i = 1;
                  _order = _order + 1;
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(
                          "Transaksi telah melebihi 30, nomor order diperbarui")));
                }
              }
            },
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }

  Widget btnEdit() {
    return RaisedButton(
      onPressed: () {
        // Validate returns true if the form is valid, or false
        // otherwise.
        if (_formKey.currentState.validate()) {
          this._formKey.currentState.save();

          final newOrder = Order(
              id: widget.order.id,
              harga: _harga,
              kodeBarang: _kodebarang,
              namaBarang: _barang,
              kodePelanggan: _kodepelanggan,
              namaPelanggan: _pelanggan,
              kodeSales: _kodesales,
              namaSales: _sales,
              tanggal: _date,
              nomorOrder: widget.order.nomorOrder.toString(),
              satuan: _satuan,
              qty: int.parse(_qty));

          OrderService _orderService = OrderService();
          _orderService.updateData(id: widget.order.id, order: newOrder);

          _scaffoldKey.currentState.showSnackBar(SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text("Berhasil merubah data")));
          Navigator.pop(context);
        }
      },
      child: Text('Simpan'),
    );
  }
}
