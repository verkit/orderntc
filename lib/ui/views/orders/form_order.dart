import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:orderntc/models/order.dart';
import 'package:orderntc/services/barang_service.dart';
import 'package:orderntc/services/order_service.dart';
import 'package:orderntc/services/pelanggan_service.dart';
import 'package:orderntc/services/sales_service.dart';
import 'package:orderntc/ui/styles/textstyle.dart';

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

  List<String> listharga = List(3);
  List<String> listsatuan = List(3);

  var _sales,
      _kodesales,
      _harga,
      _pelanggan,
      _kodepelanggan,
      _barang,
      _kodebarang = "",
      _satuan,
      _qty,
      _jual1,
      _jual2,
      _jual3,
      _kemasan1,
      _kemasan2,
      _kemasan3,
      _total = 0,
      _order;

  var _date = DateTime.now().toString().substring(0, 10);
  var tanggal = DateFormat.y().format(DateTime.now()) +
      DateFormat.M().format(DateTime.now()) +
      DateFormat.d().format(DateTime.now()) +
      DateFormat.m().format(DateTime.now()) +
      DateFormat.s().format(DateTime.now());

  int i = 1;

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
      _order = widget.order.nomorOrder;
      _total = int.parse(widget.order.harga) * widget.order.qty;
      _jual2 = "";
      _jual3 = "";
      _kemasan2 = "";
      _kemasan3 = "";
    } else {
      _order = int.parse(tanggal);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    "No order: ${_order.toString()}",
                    style: latoSubtitle,
                  ),
                  Divider(),
                  widget.order == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Inputan ke: $i",
                              style: latoSubtitle,
                            ),
                            Divider(),
                          ],
                        )
                      : Container(),
                  _salesForm(),
                  Divider(),
                  _pelangganForm(),
                  Divider(),
                  _barangForm(),
                  Text(
                    _kodebarang,
                    style: latoSubtitle,
                  ),
                  Divider(),
                  _kuantitasForm(),
                  Divider(),
                  _hargaTotalForm(),
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
        this._jual1 = suggestion.jual1();
        this._jual2 = suggestion.jual2();
        this._jual3 = suggestion.jual3();
        this._kemasan1 = suggestion.satuan1();
        this._kemasan2 = suggestion.satuan2();
        this._kemasan3 = suggestion.satuan3();
        setState(() {});
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
      listharga[0] =
          _jual1.toString().substring(0, _jual1.toString().indexOf('.'));
      listharga[1] =
          _jual2.toString().substring(0, _jual2.toString().indexOf('.'));
      listharga[2] =
          _jual3.toString().substring(0, _jual3.toString().indexOf('.'));
      // harga.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
      return listharga;
    }

    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          enabled: _jual1 == null ? false : true,
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
        setState(() {
          _total = int.parse(this._hargaController.text) *
              int.parse(this._qtyController.text);
        });
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

  Widget _hargaTotalForm() {
    return Row(
      children: <Widget>[
        Flexible(flex: 1, child: _hargaForm()),
        SizedBox(
          width: 20,
        ),
        Flexible(
          flex: 1,
          child: Text(_total.toString()),
        )
      ],
    );
  }

  Widget _satuanForm() {
    Future<List<String>> satuanSuggestion(String query) async {
      listsatuan[0] = _kemasan1;
      listsatuan[1] = _kemasan2;
      listsatuan[2] = _kemasan3;

      return listsatuan;
    }

    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        enabled: _jual1 == null ? false : true,
        controller: this._satuanController,
        decoration: new InputDecoration(
          labelText: "Satuan",
          hintText: _satuanController.text,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await satuanSuggestion(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        this._satuanController.text = suggestion;
        setState(() {});
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Satuan harap diisi';
        }
        return null;
      },
      onSaved: (value) => this._satuan = value,
    );
  }

  Widget _kuantitasForm() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 4,
          child: TextFormField(
            maxLines: 1,
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
            onChanged: (val) {
              _total = int.parse(val) * int.parse(_hargaController.text);
              setState(() {});
            },
            onSaved: (val) => _qty = val,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          flex: 1,
          child: _satuanForm(),
        )
      ],
    );
  }

  Widget btnTambah() {
    void _clearSubmitForm() {
      _barangController.clear();
      _qtyController.clear();
      _hargaController.clear();
      setState(() {
        _kodebarang = "";
      });
    }

    void _clearNewForm() {
      _salesController.clear();
      _qtyController.clear();
      _pelangganController.clear();
      _barangController.clear();
      _hargaController.clear();
      setState(() {
        i = 1;
        _order = _order + 1;
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
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
