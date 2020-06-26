class Sales {
  int id;
  String kode, sales;

  Sales({this.id, this.kode, this.sales});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kode_sales": kode,
      "nama_sales": sales,
    };
  }

  factory Sales.fromJson(Map<String, dynamic> map) {
    return Sales(
    id: map['id'],
    kode: map['kode_sales'],
    sales: map['nama_sales']);
  }

  static List<Sales> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Sales.fromJson(item)).toList();
  }

  namaSales() => sales;
  kodeSales() => kode;
}