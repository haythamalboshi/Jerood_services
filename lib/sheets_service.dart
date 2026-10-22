import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/water_schedule.dart';
import '../models/pharmacy.dart';
import '../models/emergency_contact.dart';
import '../models/advertisement.dart';
import 'storage_service.dart';

class GoogleSheetsService {
  final StorageService storage;

  GoogleSheetsService(this.storage);

  String _buildGvizUrl(String spreadsheetId, String sheetName) {
    return 'https://docs.google.com/spreadsheets/d/$spreadsheetId/gviz/tq?tqx=out:json&sheet=${Uri.encodeComponent(sheetName)}';
  }

  List<List<dynamic>> _parseGvizBody(String responseBody) {
    try {
      final startIndex = responseBody.indexOf('{');
      final endIndex = responseBody.lastIndexOf('}');
      if (startIndex == -1 || endIndex == -1) return [];

      final jsonString = responseBody.substring(startIndex, endIndex + 1);
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      final table = decoded['table'] as Map<String, dynamic>?;
      if (table == null || table['rows'] == null) return [];

      final rowsRaw = table['rows'] as List<dynamic>;
      final List<List<dynamic>> rows = [];

      for (final r in rowsRaw) {
        if (r == null || r['c'] == null) continue;
        final cells = r['c'] as List<dynamic>;
        final rowValues = cells.map((cell) {
          if (cell == null) return '';
          return (cell['f'] ?? cell['v'] ?? '').toString().trim();
        }).toList();
        rows.add(rowValues);
      }
      return rows;
    } catch (e) {
      debugPrint('Error parsing GViz JSON: $e');
      return [];
    }
  }

  Future<List<List<dynamic>>> _fetchSheetRows(String spreadsheetId, String sheetName) async {
    try {
      final url = Uri.parse(_buildGvizUrl(spreadsheetId, sheetName));
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        return _parseGvizBody(response.body);
      }
      return [];
    } catch (e) {
      debugPrint('Network error loading sheet $sheetName: $e');
      return [];
    }
  }
}
