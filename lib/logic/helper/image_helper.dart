import 'package:dio/dio.dart';

class ImageHelper {
  final dio = Dio();

  static Future<String> uploadImage(String filePath) async {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    Response response = await Dio().post(
      '://change later',
      data: formData,
    );
    return 'success';
  }
}
