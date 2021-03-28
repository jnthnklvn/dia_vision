import 'dart:convert';
import 'dart:io';

class FileUtils {
  Future<File> save(String content, String path) async {
    File file = File(path);
    List<int> bytes = [0xEF, 0xBB, 0xBF] + utf8.encode(content);
    return await file.writeAsBytes(bytes);
  }
}
