import 'package:dio/dio.dart';

class Connection {
  final Dio dio;
  const Connection(this.dio);

  Future<String> uploadFile(String filePath, String url) async {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    Response response = await dio.post(
      url,
      data: formData,
    );
    print(response.data);
    return response.data['status'].toString();
  }
}
