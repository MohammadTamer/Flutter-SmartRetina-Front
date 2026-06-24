import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/upload_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1B2E),
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.remove_red_eye, color: const Color(0xFF6366F1)),
            const SizedBox(width: 8),
            const Text('Smart Retina', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Consumer<UploadController>(
        builder: (context, upload, child) {
          if (upload.diagnosis == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insert_drive_file,
                      size: 64, color: Colors.grey[600]),
                  const SizedBox(height: 16),
                  Text(
                    'No diagnosis available',
                    style: TextStyle(color: Colors.grey[400], fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/upload'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                    ),
                    child: const Text('Upload New Scan',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }

          final diagnosis = upload.diagnosis!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Diagnosis Results',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Image Preview
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF1A1B2E),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        diagnosis.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.image_not_supported,
                                size: 64, color: Colors.grey[600]),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Disease Info Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1B2E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.medical_services,
                                color: const Color(0xFF6366F1)),
                            const SizedBox(width: 12),
                            Text(
                              'Detected Disease',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          diagnosis.disease,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6366F1),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(color: Colors.grey[700]),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.verified, color: Colors.green),
                            const SizedBox(width: 12),
                            Text(
                              'Confidence',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(diagnosis.confidence * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: diagnosis.confidence,
                          backgroundColor: Colors.grey[800],
                          color: Colors.green,
                          minHeight: 8,
                        ),
                        if (diagnosis.notes != null) ...[
                          const SizedBox(height: 24),
                          Divider(color: Colors.grey[700]),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.note, color: const Color(0xFF6366F1)),
                              const SizedBox(width: 12),
                              Text(
                                'Notes',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            diagnosis.notes!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: Colors.grey[600], size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'Analyzed on ${diagnosis.createdAt.toString().split('.')[0]}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            upload.clearDiagnosis();
                            Navigator.pushNamed(context, '/upload');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'New Scan',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Color(0xFF6366F1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Download Report',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF6366F1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
