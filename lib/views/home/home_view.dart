import 'package:flutter/material.dart';
import '../../widgets/smart_navbar.dart';

// ─── Website palette ─────────────────────────────────────────────────────────
// Home bg:      bg-[#e3f2fd]
// Hero section: bg-linear-to-b from-[#152066] via-[#2a46b5] to-[#95cbf8]
// Features bg:  bg-[#e3f2fd]
// Diseases bg:  bg-linear-to-b from-[#e3f2fd] to-white
// Footer bg:    bg-[#152066] border-t-4 border-[#1e88e5]

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: const SmartNavBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          _HeroSection(),
          _FeaturesSection(),
          _DiseasesSection(),
          _Footer(),
        ]),
      ),
    );
  }
}

// ─── Hero ─────────────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF152066), Color(0xFF2A46B5), Color(0xFF95CBF8)],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: isWide ? 80 : 48,
      ),
      child: isWide
          ? Row(children: [
              Expanded(child: _heroText(context)),
              const SizedBox(width: 48),
              _heroImage(),
            ])
          : Column(children: [
              _heroText(context),
              const SizedBox(height: 40),
              _heroImage(),
            ]),
    );
  }

  Widget _heroText(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.25,
              ),
              children: [
                TextSpan(text: 'AI-Powered Retinal\n'),
                TextSpan(
                  text: 'Disease Detection',
                  style: TextStyle(color: Color(0xFFBFDBFE)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Accurate and explainable diagnosis of retinal diseases using deep learning',
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFFEFF6FF),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/upload'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 6,
            ),
            child: const Text('Upload Retinal Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      );

  Widget _heroImage() => Container(
        width: 320,
        height: 320,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
              Border.all(color: Colors.white.withValues(alpha: 0.10), width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 24,
              spreadRadius: 4,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.network(
            'https://smartretina.vercel.app/hero_image.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFFBBDEFB),
              child: const Icon(Icons.remove_red_eye,
                  color: Color(0xFF152066), size: 100),
            ),
          ),
        ),
      );
}

// ─── Features ─────────────────────────────────────────────────────────────────
class _FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF95CBF8), Color(0xFF2A46B5), Color(0xFF152066)],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(children: [
          const Text(
            'Why Choose Our AI?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              _FeatureCard(
                icon: Icons.bolt,
                title: 'Fast Diagnosis',
                description:
                    'Quickly identify retinal diseases with AI-powered analysis in seconds.',
              ),
              _FeatureCard(
                icon: Icons.verified,
                title: 'High Accuracy',
                description:
                    'Achieve over 90% accuracy in diagnosing retinal conditions.',
              ),
              _FeatureCard(
                icon: Icons.visibility,
                title: 'Explainable Results',
                description:
                    'Understandable insights highlighting key areas of concern.',
              ),
            ],
          ),
        ]),
      );
}

class _FeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  const _FeatureCard(
      {required this.icon, required this.title, required this.description});
  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 280,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF22324D),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.22),
                        blurRadius: 20)
                  ]
                : [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8)
                  ],
          ),
          child: Column(children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF1976D2)]),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 20),
            Text(widget.title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE5EEFF))),
            const SizedBox(height: 10),
            Text(widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14, color: Color(0xFFAAB4C4), height: 1.5)),
          ]),
        ),
      );
}

// ─── Diseases ─────────────────────────────────────────────────────────────────
class _DiseasesSection extends StatelessWidget {
  static const _diseases = [
    _Disease(
        'https://smartretina.vercel.app/diabetic_retinopathy.png',
        'Diabetic Retinopathy',
        'Progressive damage to retinal blood vessels caused by long-term diabetes.'),
    _Disease(
        'https://smartretina.vercel.app/age-related.png',
        'Age-Related Macular Degeneration',
        'Degeneration of the macula affecting central vision in older adults.'),
    _Disease(
        'https://smartretina.vercel.app/retinal_vein_occlusion.png',
        'Retinal Vein Occlusion',
        'Blocked retinal veins causing impaired blood flow and vision loss.'),
    _Disease(
        'https://smartretina.vercel.app/retinal_pigmentosa.png',
        'Retinitis Pigmentosa',
        'Inherited retinal degeneration progressively affecting night and peripheral vision.'),
    _Disease(
        'https://smartretina.vercel.app/retinal_detachment.png',
        'Retinal Detachment',
        'Separation of the retina from its underlying tissue — a medical emergency.'),
  ];

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        // web: gradient from-[#e3f2fd] to-white
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF152066), Color(0xFF0F172A)],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(children: [
          const Text('Supported Diseases',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: _diseases.map((d) => _DiseaseCard(disease: d)).toList(),
          ),
        ]),
      );
}

class _Disease {
  final String imageUrl, title, description;
  const _Disease(this.imageUrl, this.title, this.description);
}

class _DiseaseCard extends StatefulWidget {
  final _Disease disease;
  const _DiseaseCard({required this.disease});
  @override
  State<_DiseaseCard> createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<_DiseaseCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF22324D)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF152066)
                    .withValues(alpha: _hovered ? 0.15 : 0.07),
                blurRadius: _hovered ? 24 : 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(widget.disease.imageUrl,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                      height: 190,
                      color: const Color(0xFFE3F2FD),
                      child: const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey, size: 48)))),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.disease.title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE5EEFF))),
                    const SizedBox(height: 8),
                    Text(widget.disease.description,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFAAB4C4),
                            height: 1.4)),
                  ]),
            ),
          ]),
        ),
      );
}

// ─── Footer ───────────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        // web: bg-[#152066] with border-t-4 border-[#1e88e5]
        decoration: const BoxDecoration(
          color: Color(0xFF152066),
          border: Border(top: BorderSide(color: Color(0xFF1E88E5), width: 4)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
          const SizedBox(height: 12),
          const Text(
            'Faculty of Computer and Information Science\nAin Shams University\nSupervised by: Dr. Dina Elsayad, T.A. Manar Sultan',
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Color(0xFFBBDEFB), fontSize: 12, height: 1.7),
          ),
          const SizedBox(height: 14),
          const Text('© 2026 Smart Retina. All rights reserved.',
              style: TextStyle(color: Color(0xFF90CAF9), fontSize: 12)),
        ]),
      );
}
