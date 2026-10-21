
import 'package:flutter/material.dart';
import 'add_transaction_page.dart';
import 'google_login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GoogleLoginPage.initializeGoogleSignIn();

  runApp(const FamilyFinanceApp());
}

class FamilyFinanceApp extends StatelessWidget {
  const FamilyFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Family Finance Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const GoogleLoginPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
appBar: AppBar(
  title: const Text('Family Finance'),
  backgroundColor: Colors.teal,
  foregroundColor: Colors.white,
  centerTitle: true,
  actions: [
    IconButton(
      tooltip: 'Logout',
      icon: const Icon(Icons.logout),
      onPressed: () async {
        try {
          await GoogleLoginPage.signOutFromGoogle();

          if (!context.mounted) return;

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const GoogleLoginPage(),
            ),
            (route) => false,
          );
        } catch (error) {
          debugPrint('Logout gagal: $error');
        }
      },
    ),
  ],
),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Saldo',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Rp 0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _summaryCard(
                  'Pemasukan',
                  'Rp 0',
                  Icons.arrow_downward,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _summaryCard(
                  'Pengeluaran',
                  'Rp 0',
                  Icons.arrow_upward,
                  Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Riwayat Transaksi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                'Belum ada transaksi',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddTransactionPage(),
    ),
  );
},
        icon: const Icon(Icons.add),
        label: const Text('Transaksi'),
      ),
    );
  }

  Widget _summaryCard(
    String title,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(title),
            const SizedBox(height: 8),
            Text(
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
