
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';

class AuthApiService {
  static Future<Map<String, dynamic>> verifyGoogleToken(
    String idToken,
  ) async {
    if (ApiConfig.baseUrl.isEmpty) {
      throw StateError('Alamat API belum dikonfigurasi.');
    }

    final apiUri = Uri.parse(ApiConfig.baseUrl);

    if (apiUri.scheme != 'https') {
      throw StateError('Koneksi API wajib menggunakan HTTPS.');
    }

    // Kirim Google ID Token ke backend.
    final client = http.Client();

    try {
      final request = http.Request('POST', apiUri)
        ..headers['Content-Type'] = 'application/json'
        ..body = jsonEncode({
          'idToken': idToken,
        })
        ..followRedirects = false;

      final streamedResponse = await client
          .send(request)
          .timeout(const Duration(seconds: 20));

      http.Response response =
          await http.Response.fromStream(streamedResponse);

      // Google Apps Script mengirimkan hasil melalui redirect.
      if (response.statusCode == 302) {
        final redirectUrl = response.headers['location'];

        if (redirectUrl == null) {
          throw Exception('Alamat redirect API tidak tersedia.');
        }

        final redirectUri = Uri.parse(redirectUrl);

        if (redirectUri.scheme != 'https' ||
            redirectUri.host != 'script.googleusercontent.com') {
          throw Exception('Tujuan redirect API tidak diizinkan.');
        }

        response = await client
            .get(redirectUri)
            .timeout(const Duration(seconds: 20));
      }

      if (response.statusCode != 200) {
        throw Exception('Koneksi autentikasi gagal.');
      }

      final result = jsonDecode(response.body);

      if (result is! Map<String, dynamic>) {
        throw const FormatException(
          'Respons autentikasi tidak valid.',
        );
      }

      if (result['success'] != true) {
        throw Exception(
          'Autentikasi gagal atau akses ditolak.',
        );
      }

      const allowedRoles = {
        'primary_owner',
        'alternative_owner',
        'family_member',
      };

      if (!allowedRoles.contains(result['role'])) {
        throw const FormatException(
          'Role pengguna tidak valid.',
        );
      }

      return result;
    } finally {
      client.close();
    }
  }
}
