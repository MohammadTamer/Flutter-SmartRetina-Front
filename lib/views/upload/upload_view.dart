import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../controllers/upload_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/smart_navbar.dart';

// web: bg-gradient-to-b from-[#eef2ff] to-white
// Footer: bg-[#152066] border-t-4 border-[#1e88e5]

class UploadView extends StatefulWidget {
  const UploadView({super.key});
  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  XFile? _xfile;
  Uint8List? _imageBytes;
  final _picker = ImagePicker();

  Future<void> _pick() async {
    final x = await _picker.pickImage(source: ImageSource.gallery);
    if (x != null) {
      final bytes = await x.readAsBytes();
      setState(() {
        _xfile = x;
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: const SmartNavBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          _hero(),
          _card(context),
          _footer(),
        ]),
      ),
    );
  }

  Widget _hero() => Container(
        width: double.infinity,
        // web: bg-gradient-to-b from-[#eef2ff] to-white pt-32 pb-20
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF152066), Color(0xFF2A46B5), Color(0xFF0F172A)],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 56, 24, 40),
        child: Column(children: [
          const Text('Upload Retinal Scan',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const Text(
              'Upload a high-quality fundus image (JPEG/PNG) to receive an instant AI-powered diagnosis report.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Color(0xFFEFF6FF), height: 1.6),
            ),
          ),
        ]),
      );

  Widget _card(BuildContext context) {
    final upload = context.watch<UploadController>();
    final auth = context.watch<AuthController>();
    return Container(
      // web: to-white background continues
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 56),
      child: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF22324D)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 30,
                  offset: const Offset(0, 10))
            ],
          ),
          child: Column(children: [
            // Decorative top bar: bg-gradient-to-r from-blue-500 to-cyan-400
            Container(
                height: 6,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  gradient: LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF22D3EE)]),
                )),
            Padding(
                padding: const EdgeInsets.all(32),
                child: Column(children: [
                  // Drop zone
                  GestureDetector(
                    onTap: _pick,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      height: 240,
                      decoration: BoxDecoration(
                        color: _imageBytes != null
                            ? const Color(0xFF172A4A)
                            : const Color(0xFF162336),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _imageBytes != null
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF3A4A66),
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: _imageBytes == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Icon(Icons.cloud_upload_outlined,
                                      size: 64, color: Colors.blue[300]),
                                  const SizedBox(height: 16),
                                  const Text('Click to upload or drag & drop',
                                      style: TextStyle(
                                          color: Color(0xFFAAB4C4),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 6),
                                  const Text('SVG, PNG, JPG (MAX. 5MB)',
                                      style: TextStyle(
                                          color: Color(0xFF9CA3AF),
                                          fontSize: 13)),
                                ])
                          : Stack(children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.memory(_imageBytes!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity)),
                              Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                      onTap: () => setState(() { _xfile = null; _imageBytes = null; }),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: const EdgeInsets.all(6),
                                        child: const Icon(Icons.close,
                                            color: Colors.white, size: 16),
                                      ))),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Color(0x66000000),
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(14)),
                                    ),
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: Colors.green, size: 18),
                                          SizedBox(width: 6),
                                          Text(
                                              'File selected. Click to change.',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13)),
                                        ]),
                                  )),
                            ]),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Analyze button: bg-[#152066] hover:bg-[#1e2b85]
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_xfile == null || upload.isLoading)
                            ? null
                            : () async {
                                if (auth.isAuthenticated) {
                                  final ok = await upload.uploadImageWeb(
                                      _xfile!, auth.user!.token!);
                                  if (ok && context.mounted) {
                                    Navigator.pushNamed(context, '/dashboard');
                                  } else if (upload.error != null &&
                                      context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(upload.error!)));
                                  }
                                } else {
                                  Navigator.pushNamed(context, '/login');
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _xfile != null
                              ? const Color(0xFF152066)
                              : const Color(0xFFD1D5DB),
                          disabledBackgroundColor: const Color(0xFF1B2A3D),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: _xfile != null ? 6 : 0,
                          shadowColor: Colors.blue.withValues(alpha: 0.25),
                        ),
                        child: upload.isLoading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2)),
                                    SizedBox(width: 12),
                                    Text('Analyzing...',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ])
                            : Text('Analyze Image',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _xfile != null
                                        ? Colors.white
                                        : const Color(0xFF9CA3AF))),
                      )),
                  if (!auth.isAuthenticated) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.info_outline,
                            color: Colors.amber[700], size: 16),
                        const SizedBox(width: 8),
                        Text('Login required to analyze images',
                            style: TextStyle(
                                color: Colors.amber[800], fontSize: 13)),
                      ]),
                    ),
                  ],
                ])),
          ]),
        ),
      )),
    );
  }

  Widget _footer() => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF152066),
          border: Border(top: BorderSide(color: Color(0xFF1E88E5), width: 4)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(Icons.remove_red_eye, color: Color(0xFF90CAF9), size: 20),
            SizedBox(width: 8),
            Text('Smart Retina',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 10),
          const Text(
            'Faculty of Computer and Information Science\nAin Shams University\nSupervised by: Dr. Dina Elsayad, T.A. Manar Sultan',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Color(0xFFBFDBFE), fontSize: 12, height: 1.7),
          ),
          const SizedBox(height: 14),
          const Text('© 2026 Smart Retina. All rights reserved.',
              style: TextStyle(color: Color(0xFF90CAF9), fontSize: 12)),
        ]),
      );
}
