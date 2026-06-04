import 'package:share_plus/share_plus.dart';

class ShareService {

  static void shareResult(String text) {

    Share.share(text);
  }
}