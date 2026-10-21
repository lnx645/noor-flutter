import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/surah.dart';

/// Klien Quran.com API v4 — sumber data yang sama dengan Noor versi web.
class QuranApi {
  QuranApi({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _dasar = 'https://api.quran.com/api/v4';

  List<Surah>? _cacheSurah;

  /// Daftar 114 surah (dengan cache memori sederhana).
  Future<List<Surah>> daftarSurah() async {
    final cache = _cacheSurah;
    if (cache != null) return cache;
    final uri = Uri.parse('$_dasar/chapters?language=id');
    final respon = await _client.get(uri);
    if (respon.statusCode != 200) {
      throw Exception('Gagal memuat daftar surah (HTTP ${respon.statusCode})');
    }
    final data = jsonDecode(utf8.decode(respon.bodyBytes)) as Map<String, dynamic>;
    final daftar = (data['chapters'] as List<dynamic>)
        .map((e) => Surah.dariJson(e as Map<String, dynamic>))
        .toList();
    _cacheSurah = daftar;
    return daftar;
  }
}
