import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../controllers/upload_controller.dart';

/// Top navbar matching the web: dark blue bg, logo, nav links, login/logout button.
class SmartNavBar extends StatefulWidget implements PreferredSizeWidget {
  const SmartNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  State<SmartNavBar> createState() => _SmartNavBarState();
}

class _SmartNavBarState extends State<SmartNavBar> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 860;
    final auth = context.watch<AuthController>();

    return Container(
      color: const Color(0xFF19246C),
      padding: EdgeInsets.symmetric(horizontal: isWide ? 32 : 16, vertical: 0),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Logo
            const Icon(Icons.remove_red_eye, color: Colors.white, size: 26),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (_) => false),
              child: const Text('Smart Retina',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold)),
            ),
            const Spacer(),
            if (isWide) ...[
              _link(context, 'Home', '/home'),
              if (auth.isAuthenticated) _link(context, 'Dashboard', '/medical-history'),
              _link(context, 'Upload', '/upload'),
              _link(context, 'Diseases', '/diseases'),
              _link(context, 'About', '/about'),
              const SizedBox(width: 8),
              if (auth.isAuthenticated)
                _authBtn(
                    context, 'Logout', Colors.red.shade800, () {
                      context.read<UploadController>().clearAllData();
                      auth.logout();
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                    })
              else
                _authBtn(context, 'Login', const Color(0xFF0D47A1),
                    () => Navigator.pushNamed(context, '/login')),
            ] else
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => _showMobileMenu(context, auth),
              ),
          ],
        ),
      ),
    );
  }

  Widget _link(BuildContext context, String label, String route) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: TextButton.styleFrom(foregroundColor: Colors.blue[100]),
      child: Text(label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }

  Widget _authBtn(
      BuildContext context, String label, Color color, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.85),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }

  void _showMobileMenu(BuildContext context, AuthController auth) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF152066),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in [
              ['Home', '/home'],
              if (auth.isAuthenticated) ['Dashboard', '/medical-history'],
              ['Upload', '/upload'],
              ['Diseases', '/diseases'],
              ['About', '/about'],
            ])
              ListTile(
                title: Text(item[0],
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, item[1]);
                },
              ),
            const Divider(color: Colors.white24),
            if (auth.isAuthenticated)
              ListTile(
                title: const Text('Logout',
                    style: TextStyle(color: Colors.redAccent)),
                onTap: () {
                  Navigator.pop(context);
                  context.read<UploadController>().clearAllData();
                  auth.logout();
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                },
              )
            else
              ListTile(
                title: const Text('Login',
                    style: TextStyle(color: Color(0xFF7DD3FC))),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
              ),
          ],
        ),
      ),
    );
  }
}
