
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricLoginPage extends StatefulWidget {
  const BiometricLoginPage({super.key});

  @override
  State<BiometricLoginPage> createState() => _BiometricLoginPageState();
}

class _BiometricLoginPageState extends State<BiometricLoginPage> {
  final LocalAuthentication _auth = LocalAuthentication();

  bool _isAuthenticating = false;
  String _message = 'Tekan tombol untuk menguji sidik jari.';

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
      _message = 'Menunggu autentikasi...';
    });

    try {
      final available = await _auth.isDeviceSupported();
      final canCheckBiometrics = await _auth.canCheckBiometrics;

      if (!available || !canCheckBiometrics) {
        if (!mounted) return;
        setState(() {
          _message = 'Biometrik tidak tersedia pada perangkat ini.';
        });
        return;
      }

      final authenticated = await _auth.authenticate(
        localizedReason:
            'Verifikasi sidik jari untuk Family Finance Management',
        biometricOnly: true,
      );

      if (!mounted) return;

      setState(() {
        _message = authenticated
            ? 'Autentikasi biometrik berhasil!'
            : 'Autentikasi dibatalkan atau gagal.';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _message = 'Terjadi kesalahan autentikasi: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uji Biometrik'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.fingerprint,
                size: 90,
                color: Colors.teal,
              ),
              const SizedBox(height: 24),
              const Text(
                'Family Finance Security',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _isAuthenticating ? null : _authenticate,
                icon: const Icon(Icons.lock_open),
                label: const Text('Uji Sidik Jari'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
