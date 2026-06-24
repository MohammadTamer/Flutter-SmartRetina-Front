import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '_auth_left_panel.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});
  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPass = false;
  bool _showConfirm = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await http.post(
        Uri.parse('https://flutter-smartretina.onrender.com/api/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailCtrl.text,
          'full_name': _nameCtrl.text,
          'password': _passCtrl.text,
        }),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        if (mounted) Navigator.pushReplacementNamed(context, '/login');
      } else {
        final data = jsonDecode(res.body);
        setState(() => _error = data['detail']?.toString() ?? 'Signup failed');
      }
    } catch (_) {
      setState(() => _error = 'Connection error. Please try again.');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;
    final desktopCardHeight =
        (size.height - 160).clamp(640.0, 836.0).toDouble();
    return Scaffold(
      backgroundColor: const Color(0xFF071126),
      body: Stack(children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0D1B3D),
                  Color(0xFF071126),
                  Color(0xFF07111F)
                ],
              ),
            ),
          ),
        ),
        SafeArea(
            child: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: isWide ? 80 : 32, horizontal: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1224),
              child: Container(
                constraints:
                    BoxConstraints(minHeight: isWide ? desktopCardHeight : 0),
                decoration: BoxDecoration(
                  color: const Color(0xFF111B2E),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF25344E)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 50,
                        offset: const Offset(0, 24))
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: isWide
                      ? IntrinsicHeight(
                          child: Row(children: [
                          Expanded(child: AuthLeftPanel(isLogin: false)),
                          Expanded(child: _formPanel(context)),
                        ]))
                      : _formPanel(context),
                ),
              ),
            ),
          )),
        )),
      ]),
    );
  }

  Widget _formPanel(BuildContext context) => Container(
        color: const Color(0xFF101A2D),
        padding: const EdgeInsets.fromLTRB(56, 28, 56, 40),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (_) => false),
                  icon: const Icon(Icons.arrow_back,
                      size: 14, color: Color(0xFF64748B)),
                  label: const Text('Back to Home',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                ),
                const SizedBox(height: 20),
                const Text('Create Account',
                    style: TextStyle(
                        color: Color(0xFFE5EEFF),
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                const Text('Get started with Smart Retina today.',
                    style: TextStyle(color: Color(0xFFAAB4C4), fontSize: 14)),
                if (_error != null) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(_error!,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 13)),
                  ),
                ],
                const SizedBox(height: 24),
                _field(
                    ctrl: _nameCtrl,
                    hint: 'Full Name',
                    icon: Icons.person_outline,
                    validator: (v) => (v == null || v.length < 2)
                        ? 'Enter your full name'
                        : null),
                const SizedBox(height: 14),
                _field(
                    ctrl: _emailCtrl,
                    hint: 'Email Address',
                    icon: Icons.email_outlined,
                    validator: (v) => (v == null || !v.contains('@'))
                        ? 'Enter a valid email'
                        : null),
                const SizedBox(height: 14),
                _field(
                    ctrl: _passCtrl,
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    obscure: !_showPass,
                    suffix: IconButton(
                      icon: Icon(
                          _showPass ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF94A3B8),
                          size: 20),
                      onPressed: () => setState(() => _showPass = !_showPass),
                    ),
                    validator: (v) => (v == null || v.length < 6)
                        ? 'Min 6 characters'
                        : null),
                const SizedBox(height: 14),
                _field(
                    ctrl: _confirmCtrl,
                    hint: 'Confirm Password',
                    icon: Icons.lock_outline,
                    obscure: !_showConfirm,
                    suffix: IconButton(
                      icon: Icon(
                          _showConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF94A3B8),
                          size: 20),
                      onPressed: () =>
                          setState(() => _showConfirm = !_showConfirm),
                    ),
                    validator: (v) => (v != _passCtrl.text)
                        ? 'Passwords do not match'
                        : null),
                const SizedBox(height: 24),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F2A78),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 6,
                        shadowColor: Colors.blue.withValues(alpha: 0.3),
                      ),
                      child: _loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2))
                          : const Text('Create Account',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                    )),
                const SizedBox(height: 20),
                _divider('Or register with'),
                const SizedBox(height: 16),
              Consumer<AuthController>(
                builder: (ctx, auth, _) => SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: auth.isLoading
                        ? null
                        : () async {
                            final ok = await auth.loginWithGoogle();
                            if (ok && ctx.mounted) {
                              Navigator.pushReplacementNamed(ctx, '/home');
                            } else if (auth.error != null && ctx.mounted) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                  SnackBar(content: Text(auth.error!)));
                            }
                          },
                    icon: Image.network('https://www.google.com/favicon.ico',
                        width: 18,
                        height: 18,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.g_mobiledata, size: 20)),
                    label: const Text('Google account',
                        style: TextStyle(color: Color(0xFFAAB4C4), fontSize: 14)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFE5EEFF)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
                const SizedBox(height: 20),
                Center(
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text('Already have an account? ',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text('Log in',
                        style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                ])),
              ],
            )),
      );

  Widget _field(
          {required TextEditingController ctrl,
          required String hint,
          required IconData icon,
          bool obscure = false,
          Widget? suffix,
          String? Function(String?)? validator}) =>
      TextFormField(
        controller: ctrl,
        obscureText: obscure,
        validator: validator,
        style: const TextStyle(color: Color(0xFFE5EEFF), fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF94A3B8), size: 18),
          suffixIcon: suffix,
          filled: true,
          fillColor: const Color(0xFF1B2A3D),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF31415D))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF31415D))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      );

  Widget _divider(String label) => Row(children: [
        const Expanded(child: Divider(color: Color(0xFF1E2E46))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(label,
                style:
                    const TextStyle(color: Color(0xFF94A3B8), fontSize: 13))),
        const Expanded(child: Divider(color: Color(0xFF1E2E46))),
      ]);
}
