import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String> downloadAndSaveImage(String url, String filename) async {
  try {
    final response = await http
        .get(Uri.parse(url))
        .timeout(Duration(seconds: 30));
    if (response.statusCode == 200) {
      final documentDirectory = await getApplicationDocumentsDirectory();
      final filePath = '${documentDirectory.path}/$filename';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } else {
      print('HTTP error: ${response.statusCode}');
      return "";
    }
  } on TimeoutException {
    print('Image download timed out!');
    return "";
  } catch (e) {
    print('Failed to download image: $e');
    return "";
  }
}
