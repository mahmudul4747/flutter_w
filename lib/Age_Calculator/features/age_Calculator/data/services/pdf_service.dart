import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PdfService {

  Future<File> generateReport(String text) async {

    final dir =
        await getApplicationDocumentsDirectory();

    final file =
        File("${dir.path}/age_report.txt");

    await file.writeAsString(text);

    return file;
  }
}