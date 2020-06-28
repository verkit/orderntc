class Barang {
  int id;
  String kode, barang, kemasan1, kemasan2, kemasan3, harga1, harga2, harga3;

  Barang(
      {this.id,
      this.harga1,
      this.harga2,
      this.harga3,
      this.kode,
      this.barang,
      this.kemasan1,
      this.kemasan2,
      this.kemasan3});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kode_barang": kode,
      "nama_barang": barang,
      "hargajual1": harga1,
      "hargajual2": harga2,
      "hargajual3": harga3,
      "kemasan1": kemasan1,
      "kemasan2": kemasan2,
      "kemasan3": kemasan3,
    };
  }

  factory Barang.fromJson(Map<String, dynamic> map) {
    return Barang(
        id: map["id"],
        kode: map["kode_barang"],
        barang: map["nama_barang"],
        harga1: map["hargajual1"],
        harga2: map["hargajual2"],
        harga3: map["hargajual3"],
        kemasan1: map["kemasan1"],
        kemasan2: map["kemasan2"],
        kemasan3: map["kemasan3"]);
  }

  static List<Barang> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Barang.fromJson(item)).toList();
  }

  String namaBarang() => barang;
  String kodeBarang() => kode;
  String satuan1() => kemasan1;
  String satuan2() => kemasan2;
  String satuan3() => kemasan3;
  String jual1() => harga1;
  String jual2() => harga2;
  String jual3() => harga3;
}
