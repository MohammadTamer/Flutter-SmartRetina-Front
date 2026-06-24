import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/smart_navbar.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/upload_controller.dart';

class MedicalHistoryView extends StatefulWidget {
  const MedicalHistoryView({super.key});

  @override
  State<MedicalHistoryView> createState() => _MedicalHistoryViewState();
}

class _MedicalHistoryViewState extends State<MedicalHistoryView> {
  bool _scansFetched = false;

  @override
  void initState() {
    super.initState();
    // Listen after frame so context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryFetchScans();
      // Also listen for auth changes (e.g. after refresh when checkAuth completes)
      context.read<AuthController>().addListener(_onAuthChanged);
    });
  }

  @override
  void dispose() {
    context.read<AuthController>().removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    _tryFetchScans();
  }

  void _tryFetchScans() {
    if (_scansFetched) return;
    final token = context.read<AuthController>().user?.token;
    if (token != null) {
      _scansFetched = true;
      context.read<UploadController>().fetchMyScans(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: const SmartNavBar(),
      body: Consumer<UploadController>(
        builder: (context, uploadController, child) {
          if (uploadController.isLoadingScans) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1)));
          }
          final reports = uploadController.myScans;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(),
                  const SizedBox(height: 32),
                  _StatusCards(reports: reports),
                  const SizedBox(height: 40),
                  if (reports.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Center(
                        child: Text(
                          'No recent scans found.',
                          style: TextStyle(color: Color(0xFF64748B), fontSize: 16),
                        ),
                      ),
                    )
                  else
                    _ReportsTable(reports: reports),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.description, color: Color(0xFF1E3A8A), size: 28),
            SizedBox(width: 12),
            Flexible(
              child: Text(
                'My Medical History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'View your past AI diagnosis reports and doctor notes.',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        if (!isWide) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/upload'),
              icon: const Icon(Icons.upload_file, size: 20),
              label: const Text('Upload New Scan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
        if (isWide)
          Positioned(
            top: 0,
            right: 0,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/upload'),
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload New Scan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _StatusCards extends StatelessWidget {
  final List<Map<String, dynamic>> reports;

  const _StatusCards({required this.reports});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    final totalScans = reports.length.toString();
    final lastCheckup = reports.isNotEmpty ? reports.first['date'] : '-';
    
    if (isWide) {
      return Row(
        children: [
          Expanded(
            child: _StatusCard(
              title: 'TOTAL SCANS',
              value: totalScans,
              color: const Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _StatusCard(
              title: 'LAST CHECKUP',
              value: lastCheckup,
              color: Colors.white,
              textColor: const Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _StatusCard(
              title: 'CURRENT STATUS',
              value: 'All Clear',
              color: Colors.white,
              textColor: const Color(0xFF22C55E),
            ),
          ),
        ],
      );
    }
    
    // Mobile: stack vertically
    return Column(
      children: [
        _StatusCard(
          title: 'TOTAL SCANS',
          value: totalScans,
          color: const Color(0xFF1E3A8A),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatusCard(
                title: 'LAST CHECKUP',
                value: lastCheckup,
                color: Colors.white,
                textColor: const Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatusCard(
                title: 'CURRENT STATUS',
                value: 'All Clear',
                color: Colors.white,
                textColor: const Color(0xFF22C55E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Color? textColor;

  const _StatusCard({
    required this.title,
    required this.value,
    required this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isBlue = color == const Color(0xFF1E3A8A);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: isBlue ? null : Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isBlue ? Colors.white70 : const Color(0xFF64748B),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textColor ?? (isBlue ? Colors.white : const Color(0xFF1E3A8A)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportsTable extends StatelessWidget {
  final List<Map<String, dynamic>> reports;

  const _ReportsTable({required this.reports});

  void _showScanImage(BuildContext context, Map<String, dynamic> report) {
    final imageUrl = report['imageUrl'] as String? ?? '';
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF0F172A),
        insetPadding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF1E3A8A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.remove_red_eye, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      report['name'] ?? 'Scan Image',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 20),
                    onPressed: () => Navigator.of(ctx).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Image
            Container(
              constraints: const BoxConstraints(maxHeight: 450),
              color: const Color(0xFF0A0B14),
              child: imageUrl.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text('No image available',
                            style: TextStyle(color: Colors.white54)),
                      ),
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (ctx, child, progress) {
                        if (progress == null) return child;
                        return const Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
                        );
                      },
                      errorBuilder: (ctx, error, stack) => const Padding(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image_not_supported, size: 48, color: Colors.white38),
                            SizedBox(height: 12),
                            Text('Image not available',
                                style: TextStyle(color: Colors.white54)),
                          ],
                        ),
                      ),
                    ),
            ),
            // Footer info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDialogInfoBox(
                          'Doctor\'s Final Diagnosis',
                          report['final_diagnosis'] ?? 'Pending Review',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDialogInfoBox(
                          'Risk Assessment Level',
                          report['risk'] ?? 'Unknown',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: _buildDialogInfoBox(
                      'Clinical Notes',
                      report['notes']?.isNotEmpty == true ? report['notes'] : 'No notes provided',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(report['diagnosis'] ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(report['date'] ?? '',
                                style: const TextStyle(color: Colors.white54, fontSize: 12)),
                          ],
                        ),
                      ),
                      _StatusBadge(report['status'] ?? ''),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Reports',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                if (isWide)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                        SizedBox(width: 8),
                        Text(
                          'Search scans...',
                          style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (isWide) ...[
            _buildTableHeader(),
            ...reports.map((report) => _buildTableRow(context, report)),
          ] else
            ...reports.map((report) => _buildMobileCard(context, report)),
        ],
      ),
    );
  }

  Widget _buildMobileCard(BuildContext context, Map<String, dynamic> report) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                report['id'],
                style: const TextStyle(
                  color: Color(0xFF1E3A8A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              _StatusBadge(report['status']),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            report['name'],
            style: const TextStyle(
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            report['diagnosis'],
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Color(0xFF94A3B8)),
              const SizedBox(width: 6),
              Text(
                report['date'],
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
              ),
              const Spacer(),
              if (report['confidence'] != '-') ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(
                    report['confidence'],
                    style: const TextStyle(fontSize: 12, color: Color(0xFF475569), fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              _RiskBadge(risk: report['risk'], text: report['diagnosis']),
              const SizedBox(width: 12),
              TextButton.icon(
                onPressed: () => _showScanImage(context, report),
                icon: const Icon(Icons.visibility, size: 16),
                label: const Text('View', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(
          top: BorderSide(color: Color(0xFFE2E8F0)),
          bottom: BorderSide(color: Color(0xFFE2E8F0)),
        ),
      ),
      child: Row(
        children: const [
          Expanded(flex: 1, child: _HeaderCell('SCAN ID')),
          Expanded(flex: 1, child: _HeaderCell('DATE')),
          Expanded(flex: 2, child: _HeaderCell('SCAN NAME')),
          Expanded(flex: 2, child: _HeaderCell('DIAGNOSIS')),
          Expanded(flex: 2, child: _HeaderCell('PREDICTION')),
          Expanded(flex: 1, child: _HeaderCell('STATUS')),
          Expanded(flex: 1, child: _HeaderCell('ACTION')),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Map<String, dynamic> report) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              report['id'],
              style: const TextStyle(
                color: Color(0xFF475569),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Color(0xFF94A3B8)),
                const SizedBox(width: 8),
                Text(
                  report['date'],
                  style: const TextStyle(color: Color(0xFF475569)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              report['name'],
              style: const TextStyle(
                color: Color(0xFF1E3A8A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              report['diagnosis'],
              style: const TextStyle(color: Color(0xFF475569)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (report['confidence'] != '-') ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      report['confidence'],
                      style: const TextStyle(fontSize: 12, color: Color(0xFF475569), fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                _RiskBadge(risk: report['risk'], text: report['diagnosis']),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: _StatusBadge(report['status']),
          ),
          Expanded(
            flex: 1,
            child: TextButton.icon(
              onPressed: () => _showScanImage(context, report),
              icon: const Icon(Icons.visibility, size: 16),
              label: const Text('View Report'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2563EB),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF64748B),
        letterSpacing: 1.0,
      ),
    );
  }
}

class _RiskBadge extends StatelessWidget {
  final String risk;
  final String text;
  const _RiskBadge({required this.risk, required this.text});

  @override
  Widget build(BuildContext context) {
    Color bgColor, textColor;
    if (risk == 'High Risk') {
      bgColor = const Color(0xFFFEE2E2);
      textColor = const Color(0xFFEF4444);
    } else if (risk == 'Moderate') {
      bgColor = const Color(0xFFFEF3C7);
      textColor = const Color(0xFFD97706);
    } else if (risk == 'Normal') {
      bgColor = const Color(0xFFDCFCE7);
      textColor = const Color(0xFF22C55E);
    } else {
      bgColor = const Color(0xFFF1F5F9);
      textColor = const Color(0xFF64748B);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final isVerified = status == 'Verified';
    return Row(
      children: [
        Icon(
          isVerified ? Icons.check_circle : Icons.schedule,
          size: 16,
          color: isVerified ? const Color(0xFF22C55E) : const Color(0xFFF59E0B),
        ),
        const SizedBox(width: 6),
        Text(
          status,
          style: TextStyle(
            color: isVerified ? const Color(0xFF22C55E) : const Color(0xFFF59E0B),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
