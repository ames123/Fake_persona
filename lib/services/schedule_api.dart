import 'dart:convert';
import 'package:http/http.dart' as http;

/// Simple API client for Schedule persistence.
///
/// Usage:
/// - Set `baseUrl` to your Node.js backend address (e.g. https://api.example.com)
/// - Call `saveOrder` to persist an ordered list of time-slot ids.
/// - Call `fetchOrder` to retrieve the saved ordering.
///
/// Expected Node.js endpoints (example):
/// POST /api/schedule/order  { order: ['ts1','ts3','ts2', ...] }
///    - Responds with 200 OK and the saved order JSON
/// GET  /api/schedule/order
///    - Responds with 200 OK and JSON { order: ['ts1','ts3', ...] }
///
/// On the Node.js side you can use Express + a simple in-memory store or a DB
/// (MongoDB/Postgres). Example minimal Express handler:
///
/// const express = require('express');
/// const app = express();
/// app.use(express.json());
/// let savedOrder = [];
/// app.post('/api/schedule/order', (req, res) => { savedOrder = req.body.order || []; res.json({ order: savedOrder }); });
/// app.get('/api/schedule/order', (req, res) => { res.json({ order: savedOrder }); });
///
/// Replace with persistent DB logic in production.

class ScheduleApi {
  // TODO: change to your Node.js server base URL
  static String baseUrl = 'http://localhost:3000';

  /// Save order of time slot ids to backend.
  /// Returns true on success.
  static Future<bool> saveOrder(List<String> orderedIds) async {
    final uri = Uri.parse('\$baseUrl/api/schedule/order');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'order': orderedIds}),
    );
    return resp.statusCode == 200;
  }

  /// Fetch saved order from backend. Returns null on failure.
  static Future<List<String>?> fetchOrder() async {
    final uri = Uri.parse('\$baseUrl/api/schedule/order');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      try {
        final data = jsonDecode(resp.body) as Map<String, dynamic>;
        final order = (data['order'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList();
        return order;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
