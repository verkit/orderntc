import 'package:flutter/material.dart';
import 'package:orderntc/models/pelanggan.dart';
import 'package:orderntc/services/pelanggan_service.dart';
import 'package:orderntc/ui/styles/textstyle.dart';

class PelangganView extends StatefulWidget {
  @override
  _PelangganViewState createState() => _PelangganViewState();
}

class _PelangganViewState extends State<PelangganView> {
  final PelangganService service = PelangganService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Data pelanggan')),
        body: SafeArea(
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(child: getPelanggansWidget()))));
  }

  Widget getPelanggansWidget() {
    return FutureBuilder(
      future: service.getPelanggan(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelanggan>> snapshot) {
        return getPelangganCardWidget(snapshot);
      },
    );
  }

  Widget getPelangganCardWidget(AsyncSnapshot<List<Pelanggan>> snapshot) {
    if (snapshot.hasError) {
      return Center(
        child:
            Text("Something wrong with message: ${snapshot.error.toString()}"),
      );
    } else if (snapshot.connectionState == ConnectionState.done) {
      List<Pelanggan> data = snapshot.data;
      return _buildListView(data);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildListView(List<Pelanggan> pelanggan) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1, color: Colors.black38),
      itemBuilder: (context, index) {
        Pelanggan data = pelanggan[index];
        return ListTile(
          leading: Icon(Icons.perm_identity),
          title: Text(data.pelanggan, style: listtileTitle,),
          subtitle: Text(data.kode, style: latoSubtitle),
        );
      },
      itemCount: pelanggan.length,
    );
  }
}
