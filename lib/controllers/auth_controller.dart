import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class AuthController extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: const String.fromEnvironment('GOOGLE_CLIENT_ID', defaultValue: '265727131959-fgapq1lg4oei1g7si6ukrl6aj1sqi89i.apps.googleusercontent.com'),
    serverClientId: kIsWeb ? null : const String.fromEnvironment('GOOGLE_CLIENT_ID', defaultValue: '265727131959-fgapq1lg4oei1g7si6ukrl6aj1sqi89i.apps.googleusercontent.com'),
  );

  AuthController() {
    checkAuth();
  }
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  static const String baseUrl = 'https://flutter-smartretina.onrender.com/api';

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'username': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = UserModel.fromJson(data);
        await _saveToken(_user!.token!);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid credentials';
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

  Future<bool> loginWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return false; // User canceled
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? token = googleAuth.accessToken ?? googleAuth.idToken;

      if (token == null) {
        _error = 'Failed to get Google token';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/auth/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _user = UserModel.fromJson(data);
        await _saveToken(_user!.token!);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Google Sign-In failed on server';
        await _googleSignIn.signOut();
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Google Sign-In error: $e';
      await _googleSignIn.signOut();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    try {
      await _googleSignIn.disconnect();
    } catch (_) {
      try {
        await _googleSignIn.signOut();
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/auth/me'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          data['access_token'] = token; // Inject token so it maps to UserModel.token
          _user = UserModel.fromJson(data);
        } else {
          await prefs.remove('token');
        }
      } catch (e) {
        // keep token if offline, or remove it. We'll leave it for now.
      }
    }
    notifyListeners();
  }
}
