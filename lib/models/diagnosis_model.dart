class DiagnosisModel {
  final String id;
  final String patientId;
  final String imagePath;
  final String disease;
  final double confidence;
  final String? notes;
  final DateTime createdAt;
  final List<Map<String, dynamic>> top3;

  DiagnosisModel({
    required this.id,
    required this.patientId,
    required this.imagePath,
    required this.disease,
    required this.confidence,
    this.notes,
    required this.createdAt,
    this.top3 = const [],
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    // Backend returns { "scan": {...}, "prediction": {...} }
    final scan = json['scan'] as Map<String, dynamic>? ?? {};
    final prediction = json['prediction'] as Map<String, dynamic>? ?? {};

    final top3Raw = prediction['top3'] as List<dynamic>? ?? [];
    final top3 = top3Raw
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    return DiagnosisModel(
      id: scan['id']?.toString() ?? '',
      patientId: scan['patient_id']?.toString() ?? '',
      imagePath: scan['image_url'] ?? '',
      disease: prediction['predicted_class'] ?? scan['ai_diagnosis'] ?? '',
      confidence: ((prediction['confidence'] ?? scan['ai_confidence'] ?? 0) as num).toDouble(),
      notes: scan['doctor_notes'],
      createdAt: DateTime.tryParse(scan['created_at'] ?? '') ?? DateTime.now(),
      top3: top3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'imagePath': imagePath,
      'disease': disease,
      'confidence': confidence,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
