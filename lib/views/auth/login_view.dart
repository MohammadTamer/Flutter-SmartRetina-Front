import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '_auth_left_panel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _remember = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
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
                          Expanded(child: AuthLeftPanel(isLogin: true)),
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

  Widget _formPanel(BuildContext context) {
    return Container(
      color: const Color(0xFF101A2D),
      padding: const EdgeInsets.fromLTRB(56, 28, 56, 40),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back to Home
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
              const Text('Welcome Back',
                  style: TextStyle(
                      color: Color(0xFFE5EEFF),
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Please enter your details to sign in.',
                  style: TextStyle(color: Color(0xFFAAB4C4), fontSize: 14)),
              const SizedBox(height: 28),

              // Email
              _field(
                  ctrl: _emailCtrl,
                  hint: 'Email Address',
                  icon: Icons.email_outlined,
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'Enter a valid email'
                      : null),
              const SizedBox(height: 14),

              // Password
              _field(
                  ctrl: _passCtrl,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscure: _obscure,
                  suffix: IconButton(
                    icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF94A3B8),
                        size: 20),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  validator: (v) =>
                      (v == null || v.length < 6) ? 'Min 6 characters' : null),
              const SizedBox(height: 12),

              // Remember me
              Row(children: [
                Checkbox(
                  value: _remember,
                  onChanged: (v) => setState(() => _remember = v ?? false),
                  activeColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                const Text('Remember me',
                    style: TextStyle(color: Color(0xFFE5EEFF), fontSize: 14)),
              ]),
              const SizedBox(height: 20),

              // Sign In button
              Consumer<AuthController>(
                  builder: (ctx, auth, _) => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: auth.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    final ok = await auth.login(
                                        _emailCtrl.text, _passCtrl.text);
                                    if (ok && ctx.mounted) {
                                      Navigator.pushReplacementNamed(
                                          ctx, '/home');
                                    } else if (auth.error != null &&
                                        ctx.mounted) {
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                          SnackBar(content: Text(auth.error!)));
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F2A78),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 6,
                            shadowColor: Colors.blue.withValues(alpha: 0.3),
                          ),
                          child: auth.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2))
                              : const Text('Sign In',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                        ),
                      )),
              const SizedBox(height: 20),

              // Divider
              _divider('Or continue with'),
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

              // Sign up link
              Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Text("Don't have an account? ",
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text('Sign up free',
                      style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
              ])),
            ],
          )),
    );
  }

  Widget _field({
    required TextEditingController ctrl,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) =>
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
