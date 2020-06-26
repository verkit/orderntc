class Order {
  int id, qty;
  String kodeSales,
      namaSales,
      kodePelanggan,
      namaPelanggan,
      kodeBarang,
      namaBarang,
      satuan,
      nomorOrder,
      tanggal,
      harga;

  Order(
      {this.id,
      this.kodeBarang,
      this.namaBarang,
      this.kodePelanggan,
      this.namaPelanggan,
      this.kodeSales,
      this.namaSales,
      this.harga,
      this.nomorOrder,
      this.qty,
      this.satuan,
      this.tanggal});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kode_sales": kodeSales,
      "nama_sales": namaSales,
      "kode_pelanggan": kodePelanggan,
      "nama_pelanggan": namaPelanggan,
      "kode_barang": kodeBarang,
      "nama_barang": namaBarang,
      "quantity": qty,
      "satuan": satuan,
      "harga": harga,
      "noorder": nomorOrder,
      "tanggal": tanggal,
    };
  }

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
        id: map["id"],
        kodeSales: map["kode_sales"],
        namaSales: map["nama_sales"],
        kodePelanggan: map["kode_pelanggan"],
        namaPelanggan: map["nama_pelanggan"],
        kodeBarang: map["kode_barang"],
        namaBarang: map["nama_barang"],
        qty: map["quantity"],
        satuan: map["satuan"],
        harga: map["harga"],
        nomorOrder: map["noorder"],
        tanggal: map["tanggal"]);
  }

  static List<Order> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Order.fromJson(item)).toList();
  }
}
