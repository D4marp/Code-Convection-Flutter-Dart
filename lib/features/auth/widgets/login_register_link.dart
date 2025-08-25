import 'package:flutter/material.dart';

/// Register link component untuk login screen
class LoginRegisterLink extends StatelessWidget {
  const LoginRegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF667eea),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const TextSpan(
              text: 'Daftar di sini',
              style: TextStyle(
                color: Color(0xFF667eea),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}