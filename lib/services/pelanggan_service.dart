import 'package:dio/dio.dart';
import 'package:orderntc/api.dart';
import 'package:orderntc/models/pelanggan.dart';

class PelangganService {
  Future<List<Pelanggan>> getPelanggan({String query}) async {
    final response = await Dio().get(Api.pelangganUrl, queryParameters: {"nama_pelanggan": query});
    if (response.statusCode == 200) {
      return Pelanggan.fromJsonList(response.data);
    } else {
      return null;
    }
  }
}