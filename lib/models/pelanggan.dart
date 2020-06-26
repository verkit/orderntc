class Pelanggan {
  int id;
  String kode, pelanggan;

  Pelanggan({this.id, this.kode, this.pelanggan});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "kode_pelanggan": kode,
      "nama_pelanggan": pelanggan,
    };
  }

  factory Pelanggan.fromJson(Map<String, dynamic> map) {
    return Pelanggan(
        id: map['id'],
        kode: map['kode_pelanggan'],
        pelanggan: map['nama_pelanggan']);
  }

  static List<Pelanggan> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Pelanggan.fromJson(item)).toList();
  }

  namaPelanggan() => pelanggan;
  kodePelanggan() => kode;
}
