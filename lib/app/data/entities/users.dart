class Users {
  final int id;
  final String nama;
  final String jabatan;
  final String instasi;
  final String kantor;

  Users({
    required this.id,
    required this.nama,
    required this.jabatan,
    required this.instasi,
    required this.kantor,
  });

  factory Users.fromRTDB(Map<dynamic, dynamic> json) {
    return Users(
      id: json['id'],
      nama: json['nama'],
      jabatan: json['jabatan'],
      instasi: json['instasi'],
      kantor: json['kantor'],
    );
  }

  Map<String, dynamic> toRTDB() {
    return {
      'id': id,
      'nama': nama,
      'jabatan': jabatan,
      'instasi': instasi,
      'kantor': kantor,
    };
  }
}
