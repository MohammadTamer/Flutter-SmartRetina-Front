import 'package:flutter/material.dart';

/// Blue left panel shared between Login and Signup — matches the web exactly.
class AuthLeftPanel extends StatelessWidget {
  final bool isLogin;
  const AuthLeftPanel({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 56),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF152066), Color(0xFF2563EB)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLogin) ...[
            const Text('AI-Powered',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    height: 1.2)),
            const Text('Precision.',
                style: TextStyle(
                    color: Color(0xFF67E8F9),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    height: 1.2)),
            const SizedBox(height: 28),
            const Text(
                'Log in to access your dashboard, manage patient scans, and utilize our deep learning diagnostic tools.',
                style: TextStyle(
                    color: Color(0xFFD3E4FF), fontSize: 22, height: 1.65)),
          ] else ...[
            const Text('Join the',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    height: 1.2)),
            const Text('Future of AI.',
                style: TextStyle(
                    color: Color(0xFF67E8F9),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    height: 1.2)),
            const SizedBox(height: 28),
            const Text(
                'Create an account to start analyzing retinal scans with cutting-edge deep learning technology.',
                style: TextStyle(
                    color: Color(0xFFD3E4FF), fontSize: 22, height: 1.65)),
            const SizedBox(height: 42),
            for (final item in [
              'Instant Diagnosis',
              'Secure Cloud Storage',
              'Detailed Reports'
            ]) ...[
              _checkItem(item),
              const SizedBox(height: 18),
            ],
          ],
        ],
      ),
    );
  }

  Widget _checkItem(String label) => Row(children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: Colors.cyan.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Center(
              child: Text('✓',
                  style: TextStyle(color: Color(0xFF67E8F9), fontSize: 13))),
        ),
        const SizedBox(width: 16),
        Text(label,
            style: const TextStyle(color: Color(0xFFEFF6FF), fontSize: 18)),
      ]);
}
