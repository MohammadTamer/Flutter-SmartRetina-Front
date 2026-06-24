import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../models/diagnosis_model.dart';

class UploadController extends ChangeNotifier {
  DiagnosisModel? _diagnosis;
  bool _isLoading = false;
  String? _error;
  double _uploadProgress = 0;
  List<Map<String, dynamic>> _myScans = [];
  bool _isLoadingScans = false;

  DiagnosisModel? get diagnosis => _diagnosis;
  bool get isLoading => _isLoading;
  String? get error => _error;
  double get uploadProgress => _uploadProgress;
  List<Map<String, dynamic>> get myScans => _myScans;
  bool get isLoadingScans => _isLoadingScans;

  static const String baseUrl = 'https://flutter-smartretina.onrender.com/api';

  Future<bool> uploadImageWeb(XFile imageFile, String token) async {
    _isLoading = true;
    _error = null;
    _uploadProgress = 0;
    notifyListeners();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/scans/predict'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      final bytes = await imageFile.readAsBytes();
      final mimeType = imageFile.mimeType ?? 'image/jpeg';
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: imageFile.name,
        contentType: MediaType.parse(mimeType),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _diagnosis = DiagnosisModel.fromJson(data);
        _isLoading = false;
        _uploadProgress = 1.0;
        notifyListeners();
        return true;
      } else {
        _error = 'Upload failed (${response.statusCode}): ${response.body}';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Connection error';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearDiagnosis() {
    _diagnosis = null;
    _error = null;
    _uploadProgress = 0;
    notifyListeners();
  }

  void clearAllData() {
    _diagnosis = null;
    _error = null;
    _uploadProgress = 0;
    _myScans = [];
    notifyListeners();
  }

  Future<void> fetchMyScans(String token) async {
    _isLoadingScans = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/scans/my-scans'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _myScans = data.map((scan) {
          final aiDiagnosis = scan["ai_diagnosis"] ?? 'Unknown';
          var riskLevel = scan["risk_level"] ?? 'Unknown';
          
          if (riskLevel == 'Unknown' && aiDiagnosis != 'Unknown') {
            final lowerDiag = aiDiagnosis.toLowerCase();
            if (lowerDiag.contains('healthy') || lowerDiag.contains('normal')) {
              riskLevel = 'Normal';
            } else if (lowerDiag.contains('diabetic') || lowerDiag.contains('retinopathy') || lowerDiag.contains('glaucoma')) {
              riskLevel = 'High Risk';
            } else {
              riskLevel = 'Moderate';
            }
          }

          return {
            'id': '#SR-${scan["id"]}',
            'rawId': scan["id"],
            'date': _formatDate(scan["upload_date"]),
            'name': scan["scan_name"] ?? 'Scan',
            'diagnosis': aiDiagnosis,
            'final_diagnosis': scan["final_diagnosis"],
            'notes': scan["doctor_notes"],
            'confidence': scan["ai_confidence"] != null ? '${(scan["ai_confidence"] * 100).toStringAsFixed(1)}%' : '-',
            'risk': riskLevel,
            'status': scan["status"] ?? 'Pending',
            'imageUrl': scan["image_url"] ?? '',
          };
        }).toList().cast<Map<String, dynamic>>();
        
        // Sort descending so the newest scan is at the top
        _myScans.sort((a, b) => (b["rawId"] as int).compareTo(a["rawId"] as int));
      }
    } catch (e) {
      debugPrint('Error fetching scans: $e');
    } finally {
      _isLoadingScans = false;
      notifyListeners();
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'Unknown Date';
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return dateStr;
    }
  }
}
