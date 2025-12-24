import 'dart:convert';
import 'dart:io';

class ApiServer {
  static final ApiServer _instance = ApiServer._internal();

  factory ApiServer() {
    return _instance;
  }

  ApiServer._internal();

  // دالة لتحويل البيانات إلى JSON (String).
  String convertToJson(Map<String, dynamic> data) {
    try {
      return jsonEncode(data);
    } catch (e) {
      print('Failed to convert data to JSON: $e');
      return '{}';
    }
  }

  // دالة لحفظ البيانات في ملف JSON.
  Future<void> saveObjectToJson(Map<String, dynamic> data, String fileName, {String? customPath}) async {
    try {
      final directory = customPath != null ? Directory(customPath) : Directory.systemTemp;
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final File file = File('${directory.path}/$fileName');
      final String jsonString = convertToJson(data); // استخدام الدالة هنا.
      await file.writeAsString(jsonString);

      print('Data saved to JSON file: ${file.path}');
    } catch (e) {
      print('Failed to save data: $e');
    }
  }
}
