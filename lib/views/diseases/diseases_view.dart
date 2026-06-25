import 'package:flutter/material.dart';
import '../../widgets/smart_navbar.dart';

// web: main bg = bg-[#f8fafc]
// Header: bg-gradient-to-b from-blue-50 to-white
// Cards: bg-white
// Footer: bg-[#152066] border-t-4 border-[#1e88e5]

class DiseasesView extends StatelessWidget {
  const DiseasesView({super.key});

  static const _diseases = [
    _Disease(
      title: 'Diabetic Retinopathy',
      desc:
          'Progressive damage to retinal blood vessels caused by long-term diabetes.',
      longDesc:
          'Diabetic Retinopathy is caused by prolonged high blood sugar levels that damage the small blood vessels of the retina. Early stages may be asymptomatic, but advanced stages can lead to severe vision loss or blindness.',
      img: 'https://smartretina.vercel.app/diabetic_retinopathy.png',
      slug:
          'https://www.mayoclinic.org/diseases-conditions/diabetic-retinopathy/symptoms-causes/syc-20371611',
    ),
    _Disease(
      title: 'Age-Related Macular Degeneration',
      desc: 'Degeneration of the macula affecting central vision.',
      longDesc:
          'Age-Related Macular Degeneration affects the macula, the central part of the retina responsible for detailed vision. It commonly impacts older adults and interferes with reading and face recognition.',
      img: 'https://smartretina.vercel.app/age-related.png',
      slug:
          'https://www.nei.nih.gov/eye-health-information/eye-conditions-and-diseases/age-related-macular-degeneration',
    ),
    _Disease(
      title: 'Retinal Vein Occlusion',
      desc: 'Blocked retinal veins causing impaired blood flow.',
      longDesc:
          'Retinal Vein Occlusion occurs when a retinal vein becomes blocked, leading to blood leakage, swelling, and reduced oxygen supply to retinal tissues.',
      img: 'https://smartretina.vercel.app/retinal_vein_occlusion.png',
      slug:
          'https://my.clevelandclinic.org/health/diseases/14206-retinal-vein-occlusion-rvo',
    ),
    _Disease(
      title: 'Glaucoma',
      desc: 'Progressive optic nerve damage often linked to high eye pressure.',
      longDesc:
          'Glaucoma is a group of eye diseases that damage the optic nerve, often due to increased intraocular pressure. It usually develops gradually without noticeable symptoms in the early stages and can lead to irreversible vision loss if left untreated. Early diagnosis and treatment can help slow or prevent further vision damage.',
      img: 'https://smartretina.vercel.app/retinal_pigmentosa.png',
      slug: 'https://en.wikipedia.org/wiki/Glaucoma',
    ),
    _Disease(
      title: 'Retinal Detachment',
      desc: 'Separation of the retina from underlying tissue.',
      longDesc:
          'Retinal Detachment is a medical emergency in which the retina separates from its supporting layers, cutting off oxygen supply and potentially causing permanent vision loss.',
      img: 'https://smartretina.vercel.app/retinal_detachment.png',
      slug:
          'https://www.mayoclinic.org/diseases-conditions/retinal-detachment/symptoms-causes/syc-20351344',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: const SmartNavBar(),
      body: SingleChildScrollView(
          child: Column(children: [
        _header(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
              children: List.generate(
                  _diseases.length,
                  (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _DiseaseCard(
                            disease: _diseases[i], reversed: i % 2 != 0),
                      ))),
        ),
        _footer(),
      ])),
    );
  }

  Widget _header() => Container(
        width: double.infinity,
        // web: bg-gradient-to-b from-blue-50 to-white
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF152066), Color(0xFF2A46B5), Color(0xFF0F172A)],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 64, 24, 48),
        child: Column(children: [
          const Text('Retinal Diseases We Detect',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Advanced AI-driven analysis for early detection and accurate understanding of critical retinal conditions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, color: Color(0xFFEFF6FF), height: 1.6),
            ),
          ),
        ]),
      );

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
            'Faculty of Computer and Information Science\nAin Shams University',
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

class _DiseaseCard extends StatefulWidget {
  final _Disease disease;
  final bool reversed;
  const _DiseaseCard({required this.disease, required this.reversed});
  @override
  State<_DiseaseCard> createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<_DiseaseCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    final d = widget.disease;

    final imgWidget = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(d.img,
          height: isWide ? 300 : 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
              height: 200,
              color: const Color(0xFFEFF6FF),
              child: const Icon(Icons.image_not_supported,
                  color: Colors.grey, size: 48))),
    );

    final textWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(d.title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE5EEFF))),
        const SizedBox(height: 12),
        Text(d.longDesc,
            style: const TextStyle(
                fontSize: 14, color: Color(0xFFAAB4C4), height: 1.6)),
        const SizedBox(height: 16),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _tag(
              'AI Detection', const Color(0xFFDBEAFE), const Color(0xFF1D4ED8)),
          _tag('Early Diagnosis', const Color(0xFFDCFCE7),
              const Color(0xFF15803D)),
          _tag('Vision Risk', const Color(0xFFF3E8FF), const Color(0xFF7E22CE)),
        ]),
        const SizedBox(height: 20),
        // web: bg-gradient-to-r from-blue-600 to-cyan-500
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF06B6D4)]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Text('Learn More',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF22324D)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF152066)
                  .withValues(alpha: _hovered ? 0.18 : 0.08),
              blurRadius: _hovered ? 48 : 20,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.reversed
                    ? [
                        Expanded(child: textWidget),
                        const SizedBox(width: 32),
                        Expanded(child: imgWidget)
                      ]
                    : [
                        Expanded(child: imgWidget),
                        const SizedBox(width: 32),
                        Expanded(child: textWidget)
                      ])
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [imgWidget, const SizedBox(height: 20), textWidget]),
      ),
    );
  }

  Widget _tag(String label, Color bg, Color fg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: TextStyle(
                color: fg, fontSize: 12, fontWeight: FontWeight.w600)),
      );
}

class _Disease {
  final String title, desc, longDesc, img, slug;
  const _Disease(
      {required this.title,
      required this.desc,
      required this.longDesc,
      required this.img,
      required this.slug});
}
