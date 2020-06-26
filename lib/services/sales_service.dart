import 'package:dio/dio.dart';
import 'package:orderntc/api.dart';
import 'package:orderntc/models/sales.dart';

class SalesService {
  Future<List<Sales>> getSales({String query}) async {
    final response = await Dio().get(Api.salesUrl, queryParameters: {"nama_sales": query});
    if (response.statusCode == 200) {
      return Sales.fromJsonList(response.data);
    } else {
      return null;
    }
  }
}
