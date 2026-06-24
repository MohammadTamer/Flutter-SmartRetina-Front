import 'package:flutter/material.dart';
import '../../widgets/smart_navbar.dart';

// Web exact: main bg = bg-slate-50 = #f8fafc
// Challenge section bg = bg-white
// Tech section bg = bg-slate-50 + border-y border-gray-200
// Team section bg = bg-white
// Footer bg = bg-[#152066] with border-t-4 border-[#1e88e5]

const _teamMembers = [
  _Member('Abdallah Sayed', 'Flutter Developer'),
  _Member('Mariam Rahab', 'Backend Developer'),
  _Member('Moamen Mohamed', 'Flutter Developer'),
  _Member('Reda Mohamed', 'Full Stack Developer'),
  _Member('Mohamed Tamer', 'AI Engineer'),
  _Member('Marwan Ashraf', 'AI Engineer'),
];

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: const SmartNavBar(),
      body: SingleChildScrollView(
        child: Column(children: const [
          _HeroSection(),
          _ChallengeSection(),
          _TeamSection(),
          _Footer(),
        ]),
      ),
    );
  }
}

// ── Hero ──────────────────────────────────────────────────────────────────────
// web: pt-32 pb-20 px-6 text-center max-w-4xl mx-auto  bg = bg-slate-50
class _HeroSection extends StatelessWidget {
  const _HeroSection();
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF152066), Color(0xFF2A46B5), Color(0xFF0F172A)],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 80, 24, 64),
        child: Column(children: [
          // Badge: bg-blue-50 text-blue-600 rounded-full
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'Graduation Project 2026',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // h1: text-4xl md:text-6xl font-extrabold text-[#152066]
          const Text(
            'AI that sees what',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.15),
          ),
          ShaderMask(
            shaderCallback: (r) => const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF22D3EE)]).createShader(r),
            child: const Text(
              'the human eye might miss.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.15),
            ),
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: const Text(
              'Smart Retina is an advanced diagnostic tool designed to assist ophthalmologists in detecting retinal diseases early, accurately, and instantly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17, color: Color(0xFFEFF6FF), height: 1.75),
            ),
          ),
        ]),
      );
}

// ── Challenge & Solution ──────────────────────────────────────────────────────
// web: py-20 bg-white
class _ChallengeSection extends StatelessWidget {
  const _ChallengeSection();
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
      child: isWide
          ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: _visual()),
              const SizedBox(width: 56),
              Expanded(child: _text()),
            ])
          : Column(children: [_visual(), const SizedBox(height: 40), _text()]),
    );
  }

  Widget _visual() => Container(
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF152066), Color(0xFF2563EB)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2563EB).withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 16),
            )
          ],
        ),
        child: Stack(children: [
          Center(
              child: Icon(Icons.biotech,
                  size: 120, color: Colors.white.withValues(alpha: 0.12))),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('94% Accuracy',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    Text('Achieved on validation datasets',
                        style:
                            TextStyle(color: Colors.blue[100], fontSize: 12)),
                  ]),
            ),
          ),
        ]),
      );

  Widget _text() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('The Challenge',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: 12),
        const Text(
          'Retinal diseases like Diabetic Retinopathy are the leading cause of blindness. However, diagnosis requires specialized doctors who are often overworked or unavailable in rural areas. Manual screening is slow and prone to human error.',
          style:
              TextStyle(color: Color(0xFFCBD5E1), height: 1.75, fontSize: 15),
        ),
        const SizedBox(height: 28),
        const Divider(color: Color(0xFF334155)),
        const SizedBox(height: 28),
        const Text('Our Solution',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2563EB))),
        const SizedBox(height: 12),
        const Text(
          'We trained a Convolutional Neural Network (CNN) on thousands of medical fundus images. Our platform allows any doctor to upload a scan and get a diagnosis in seconds, acting as a reliable "second opinion" to prevent misdiagnosis.',
          style:
              TextStyle(color: Color(0xFFCBD5E1), height: 1.75, fontSize: 15),
        ),
      ]);
}

// ── Tech Stack ────────────────────────────────────────────────────────────────
// web: py-16 bg-slate-50 border-y border-gray-200
class _TechSection extends StatelessWidget {
  static const _techs = [
    _Tech(Icons.code, 'Next.js 14', 'Frontend Framework', Color(0xFF3B82F6)),
    _Tech(Icons.dns, 'FastAPI (Python)', 'High-Performance API',
        Color(0xFF22C55E)),
    _Tech(
        Icons.biotech, 'TensorFlow', 'Deep Learning Model', Color(0xFFF97316)),
    _Tech(
        Icons.favorite, 'Medical Data', 'Curated Datasets', Color(0xFFEF4444)),
  ];
  const _TechSection();
  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF111827),
          border: Border.symmetric(
            horizontal: BorderSide(color: Color(0xFF334155)),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
        child: Column(children: [
          // text-gray-400 font-bold uppercase tracking-widest
          const Text('Powered by Modern Tech',
              style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5)),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: _techs.map((t) => _TechCard(tech: t)).toList(),
          ),
        ]),
      );
}

class _TechCard extends StatefulWidget {
  final _Tech tech;
  const _TechCard({required this.tech});
  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 160,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF22324D)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hovered ? 0.10 : 0.04),
                blurRadius: _hovered ? 16 : 6,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(children: [
            Icon(widget.tech.icon, color: widget.tech.color, size: 36),
            const SizedBox(height: 12),
            Text(widget.tech.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFFE5EEFF))),
            const SizedBox(height: 4),
            Text(widget.tech.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          ]),
        ),
      );
}

// ── Team ──────────────────────────────────────────────────────────────────────
// web: py-20 bg-white
class _TeamSection extends StatelessWidget {
  const _TeamSection();
  @override
  Widget build(BuildContext context) => Container(
        color: const Color(0xFF111827),
        padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 24),
        child: Column(children: [
          const Text('Meet the Team',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 12),
          const Text(
            'Built with passion by the students of the Faculty of Computer Science.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 14),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: _teamMembers.map((m) => _TeamCard(member: m)).toList(),
          ),
        ]),
      );
}

class _TeamCard extends StatefulWidget {
  final _Member member;
  const _TeamCard({required this.member});
  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 180,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            // web: bg-slate-50 hover:bg-blue-50
            color: const Color(0xFF142033),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF22324D)),
          ),
          child: Column(children: [
            // web: FaUserCircle text-blue-200 group-hover:text-blue-300
            Icon(Icons.account_circle_rounded,
                size: 80,
                color: _hovered
                    ? const Color(0xFF93C5FD)
                    : const Color(0xFFBFDBFE)),
            const SizedBox(height: 12),
            Text(widget.member.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFFE5EEFF))),
            const SizedBox(height: 4),
            Text(widget.member.role,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 14),
            AnimatedOpacity(
              opacity: _hovered ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.link, color: Color(0xFF9CA3AF), size: 18),
                    SizedBox(width: 12),
                    Icon(Icons.code, color: Color(0xFF9CA3AF), size: 18),
                  ]),
            ),
          ]),
        ),
      );
}

// ── Footer ────────────────────────────────────────────────────────────────────
// web: bg-[#152066] text-white py-8 px-6 border-t-4 border-[#1e88e5]
class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) => Container(
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
            'Faculty of Computer and Information Science\nAin Shams University\nSupervised by: Dr. Dina Elsayad , T.A. Manar Sultan',
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

class _Member {
  final String name, role;
  const _Member(this.name, this.role);
}

class _Tech {
  final IconData icon;
  final String title, subtitle;
  final Color color;
  const _Tech(this.icon, this.title, this.subtitle, this.color);
}
