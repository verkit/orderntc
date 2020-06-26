import 'package:flutter/material.dart';
import 'package:orderntc/models/sales.dart';
import 'package:orderntc/services/sales_service.dart';
import 'package:orderntc/ui/styles/textstyle.dart';

class SalesView extends StatefulWidget {
  @override
  _SalesViewState createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  SalesService salesService;

  @override
  void initState() {
    super.initState();
    salesService = SalesService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Data sales')),
        body: SafeArea(
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(child: getSalessWidget()))));
  }

  Widget getSalessWidget() {
    return FutureBuilder(
      future: salesService.getSales(),
      builder: (BuildContext context, AsyncSnapshot<List<Sales>> snapshot) {
        return getSalesCardWidget(snapshot);
      },
    );
  }

  Widget getSalesCardWidget(AsyncSnapshot<List<Sales>> snapshot) {
    if (snapshot.hasError) {
      return Center(
        child:
            Text("Something wrong with message: ${snapshot.error.toString()}"),
      );
    } else if (snapshot.connectionState == ConnectionState.done) {
      List<Sales> data = snapshot.data;
      return _buildListView(data);
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildListView(List<Sales> sales) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1, color: Colors.black38),
      itemBuilder: (context, index) {
        Sales data = sales[index];
        return ListTile(
          leading: Icon(Icons.perm_identity),
          title: Text(data.sales, style: listtileTitle,),
          subtitle: Text(data.kode, style: latoSubtitle,),
        );
      },
      itemCount: sales.length,
    );
  }
}
