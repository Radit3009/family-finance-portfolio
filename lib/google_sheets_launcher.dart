
import 'package:url_launcher/url_launcher.dart';

import 'google_sheets_config.dart';

class GoogleSheetsLauncher {
  static Future<void> openSpreadsheet() async {
    final Uri spreadsheetUri =
        Uri.parse(GoogleSheetsConfig.spreadsheetUrl);

    final bool opened = await launchUrl(
      spreadsheetUri,
      mode: LaunchMode.externalApplication,
    );

    if (!opened) {
      throw Exception('Gagal membuka Google Sheets.');
    }
  }
}
