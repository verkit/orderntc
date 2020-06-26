import 'package:flutter/material.dart';
import 'package:orderntc/models/barang.dart';
import 'package:orderntc/services/barang_service.dart';
import 'package:orderntc/ui/styles/textstyle.dart';

class BarangView extends StatefulWidget {
  @override
  _BarangViewState createState() => _BarangViewState();
}

class _BarangViewState extends State<BarangView> {
  final BarangService service = BarangService();
  final _formKey = GlobalKey<FormState>();
  var barang = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Data Barang')),
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
                        barang = value;
                      });
                    },
                    decoration: new InputDecoration(
                      labelText: "Cari barang",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(),
                      ),
                    ),
                  )),
              getBarangsWidget(query: barang)
            ],
          ),
        )));
  }

  Widget getBarangsWidget({String query}) {
    return FutureBuilder(
      future: service.getBarang(query: query),
      builder: (BuildContext context, AsyncSnapshot<List<Barang>> snapshot) {
        return getBarangCardWidget(snapshot);
      },
    );
  }

  Widget getBarangCardWidget(AsyncSnapshot<List<Barang>> snapshot) {
    if (snapshot.hasError) {
      return Center(
        child:
            Text("Something wrong with message: ${snapshot.error.toString()}"),
      );
    } else if (snapshot.connectionState == ConnectionState.done) {
      List<Barang> data = snapshot.data;
      return _buildListView(data);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildListView(List<Barang> pelanggan) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1, color: Colors.black38),
      itemBuilder: (context, index) {
        Barang data = pelanggan[index];
        return ListTile(
          // leading: Icon(Icons.input),
          title: Text(data.barang, style: listtileTitle,),
          subtitle: Text(data.kode, style: latoSubtitle),
        );
      },
      itemCount: pelanggan.length >= 50 ? 50 : pelanggan.length,
    );
  }
}
