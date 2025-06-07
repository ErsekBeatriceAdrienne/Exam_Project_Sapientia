import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../profile/login/login_page.dart';

class LoginRequiredPage extends StatelessWidget {
  const LoginRequiredPage({super.key, required this.toggleTheme});
  final VoidCallback toggleTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            Text(
                AppLocalizations.of(context)!.must_login_text,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(toggleTheme: toggleTheme),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.login_text),
            ),
          ],
        ),
      ),
    );
  }
}
