import 'dart:io';

class FileUtils {
  Future<File> save(String content, String path) async {
    File file = File(path);
    return await file.writeAsString(content);
  }
}
