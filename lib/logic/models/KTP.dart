import 'package:dio/dio.dart';

class KTP {
  final String nik;
  final String nama;
  final String tempatLahir;
  final String tanggalLahir;
  final String jenisKelamin;
  final String golDarah;
  final String alamat;
  final String agama;
  final String statusPerkawinan;
  final String pekerjaan;
  final String kewarganegaraan;

  const KTP({
    required this.nik,
    required this.nama,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.golDarah,
    required this.alamat,
    required this.agama,
    required this.statusPerkawinan,
    required this.pekerjaan,
    required this.kewarganegaraan,
  });

  factory KTP.fromJson(Map<String, dynamic> json) {
    return KTP(
      nik: json['nik'] ?? '',
      nama: json['nama'] ?? '',
      tempatLahir: json['tempat_lahir'] ?? '',
      tanggalLahir: json['tgl_lahir'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      golDarah: json['gol_darah'] ?? '',
      alamat: json['alamat'] ?? '',
      agama: json['agama'] ?? '',
      statusPerkawinan: json['status_perkawinan'] ?? '',
      pekerjaan: json['pekerjaan'] ?? '',
      kewarganegaraan: json['kewarganegaraan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nik': nik,
      'nama': nama,
      'tempat_lahir': tempatLahir,
      'tgl_lahir': tanggalLahir,
      'jenis_kelamin': jenisKelamin,
      'gol_darah': golDarah,
      'alamat': alamat,
      'agama': agama,
      'status_perkawinan': statusPerkawinan,
      'pekerjaan': pekerjaan,
      'kewarganegaraan': kewarganegaraan,
    };
  }

  static Future<KTP?> getDataByUploadImage(String filePath, String url, Dio dio) async {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    late Response response;
    try {
      response = await dio.post(
        url,
        data: formData,
      );
    } on DioException catch (_) {
      return null;
    }
    return KTP.fromJson(response.data as Map<String, dynamic>);
  }
}
