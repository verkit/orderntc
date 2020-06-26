class Barang {
  int id;
  String kode, barang, satuan, harga1, harga2, harga3;

  Barang(
      {this.id,
      this.harga1,
      this.harga2,
      this.harga3,
      this.kode,
      this.barang,
      this.satuan});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kode_barang": kode,
      "nama_barang": barang,
      "hargajual1": harga1,
      "hargajual2": harga2,
      "hargajual3": harga3,
      "nama_kemasan": satuan,
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
        satuan: map["nama_kemasan"]);
  }

  static List<Barang> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Barang.fromJson(item)).toList();
  }

  String namaBarang() => barang;
  String kodeBarang() => kode;
  String satuanBarang() => satuan.substring(4,7);
  String jual1() => harga1;
  String jual2() => harga2;
  String jual3() => harga3;
}
