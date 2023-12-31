import 'package:dio/dio.dart';
import 'package:viet_chronicle/models/quiz.dart';
import 'package:viet_chronicle/utils/global_data.dart';

class VideoController {
  final Dio _dio = Dio();
  String videoURL = "";
  String videoName = "";

  Future<void> fetchVideo(int lessonId) async {
    try {
      final String baseURL =
          await GlobalData.storage.read(key: "base_url") as String;
      final String adminSecret =
          await GlobalData.storage.read(key: "admin_secret") as String;
      final response = await _dio.get("$baseURL/videos",
          options: Options(headers: {
            "content-type": "application/json",
            "x-hasura-admin-secret": adminSecret
          }),
          queryParameters: {"id": lessonId});
      final data = response.data["videos"][0];
      videoURL = data["video_link"];
      videoName = data["video_name"];
      print(data);
      // questions = result;
    } catch (e) {
      print(e);
    }
  }
}
