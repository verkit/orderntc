import 'package:dio/dio.dart';
import 'package:orderntc/api.dart';
import 'package:orderntc/models/barang.dart';

class BarangService {
  Future<List<Barang>> getBarang({String query}) async {
    final response =
        await Dio().get(Api.barangUrl, queryParameters: {"nama_barang": query});
    if (response.statusCode == 200) {
      return Barang.fromJsonList(response.data);
    } else {
      return null;
    }
  }
}
