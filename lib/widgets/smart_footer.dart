import 'package:flutter/material.dart';

/// Shared footer matching web: bg-[#152066] border-t-4 border-[#1e88e5]
class SmartFooter extends StatelessWidget {
  const SmartFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF152066),
        border: Border(top: BorderSide(color: Color(0xFF1E88E5), width: 4)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Column(children: [
        // Logo row
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(Icons.remove_red_eye, color: Color(0xFF90CAF9), size: 20),
          SizedBox(width: 8),
          Text('Smart Retina',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 8),
        // Vertical divider line (web uses a flex row with divider on desktop)
        Container(width: 32, height: 1, color: const Color(0xFF3B5BB5)),
        const SizedBox(height: 12),
        const Text(
          'Faculty of Computer and Information Science\nAin Shams University',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFFBFDBFE),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.6),
        ),
        const SizedBox(height: 4),
        RichText(
            text: const TextSpan(
          style: TextStyle(color: Color(0xFF93C5FD), fontSize: 12),
          children: [
            TextSpan(text: 'Supervised by: '),
            TextSpan(
                text: 'Dr. Dina Elsayad',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            TextSpan(text: ' , '),
            TextSpan(
                text: 'Manar Sultan',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        )),
        const SizedBox(height: 16),
        const Text('© 2026 Smart Retina. All rights reserved.',
            style: TextStyle(
                color: Color(0xFF90CAF9),
                fontSize: 12,
                fontWeight: FontWeight.w300)),
      ]),
    );
  }
}
