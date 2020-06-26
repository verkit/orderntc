import 'package:dio/dio.dart';
import 'package:orderntc/api.dart';
import 'package:orderntc/models/order.dart';

class OrderService {
  Future<List<Order>> getDataOrder(
      {String order, String sales, String tanggal}) async {
    final response = await Dio().get(Api.orderUrl, queryParameters: {
      "noorder": order,
      "nama_sales": sales,
      "tanggal": tanggal
    });
    if (response.statusCode == 200) {
      return Order.fromJsonList(response.data);
    } else {
      return null;
    }
  }
  
  Future<List<Order>> getDataByNomor(String nomor) async {
    final response = await Dio().get(Api.noOrderUrl + "/$nomor");
    if (response.statusCode == 200) {
      return Order.fromJsonList(response.data);
    } else {
      return null;
    }
  }

  Future<List<Order>> getDataBySales(
      {String sales, String tglawal, String tglakhir}) async {
    final response = await Dio().get(Api.orderSalesUrl + "/$sales", queryParameters: {
      "tanggalakhir": tglakhir,
      "tanggalawal": tglawal,
    });
    if (response.statusCode == 200) {
      return Order.fromJsonList(response.data);
    } else {
      return null;
    }
  }

  Future<bool> postData(Order order) async {
    final response = await Dio().post(Api.orderUrl, data: order.toJson());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateData({int id, Order order}) async {
    final response =
        await Dio().put(Api.orderUrl + "/$id", data: order.toJson());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteData({int id}) async {
    final response = await Dio().delete(Api.orderUrl + "/$id");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
