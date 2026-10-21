import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_api_service.dart';
import 'google_sheets_launcher.dart';

class GoogleLoginPage extends StatelessWidget {
  const GoogleLoginPage({super.key});

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<void> signOutFromGoogle() async {
  await _googleSignIn.signOut();
  debugPrint('Google Sign-Out berhasil');
}
  static Future<void> initializeGoogleSignIn() async {
  await _googleSignIn.initialize(
    serverClientId:
        'YOUR_GOOGLE_WEB_CLIENT_ID.apps.googleusercontent.com',
  );
}

static Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount account =
        await _googleSignIn.authenticate();

    debugPrint('Google Sign-In berhasil');

    final GoogleSignInAuthentication authentication =
    account.authentication;

final String? idToken = authentication.idToken;

if (idToken != null && idToken.isNotEmpty) {
  debugPrint('Memulai verifikasi autentikasi backend');

  try {
    await AuthApiService.verifyGoogleToken(idToken);

    debugPrint('Autentikasi backend berhasil');
    if (!context.mounted) return;

await GoogleSheetsLauncher.openSpreadsheet();

  } catch (error) {
    debugPrint('Autentikasi backend belum berhasil');
  }
}


if (idToken != null && idToken.isNotEmpty) {
  debugPrint('Google ID Token tersedia');
} else {
  debugPrint('Google ID Token tidak tersedia');
}

  } on GoogleSignInException catch (error) {
    debugPrint('Google Sign-In gagal: ${error.code}');
  } catch (error) {
    debugPrint('Terjadi kesalahan saat autentikasi');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Finance Login'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
  await GoogleLoginPage.signInWithGoogle(context);
},
          icon: const Icon(Icons.login),
          label: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}


