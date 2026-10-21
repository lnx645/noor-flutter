// Uji asap kerangka + daftar surah: aplikasi tampil dengan navigasi bawah
// 4 bagian; tab Al-Qur'an memuat daftar surah dari API (klien disuntik tiruan).

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:noor/data/quran_api.dart';
import 'package:noor/main.dart';

QuranApi apiTiruan() {
  final client = MockClient((request) async {
    final tubuh = jsonEncode({
      'chapters': [
        {
          'id': 1,
          'name_simple': 'Al-Fatihah',
          'name_arabic': 'الفاتحة',
          'translated_name': {'name': 'Pembukaan'},
          'verses_count': 7,
          'revelation_place': 'makkah',
        },
        {
          'id': 2,
          'name_simple': 'Al-Baqarah',
          'name_arabic': 'البقرة',
          'translated_name': {'name': 'Sapi Betina'},
          'verses_count': 286,
          'revelation_place': 'madinah',
        },
      ],
    });
    return http.Response.bytes(utf8.encode(tubuh), 200,
        headers: {'content-type': 'application/json; charset=utf-8'});
  });
  return QuranApi(client: client);
}

void main() {
  testWidgets('Kerangka utama tampil & navigasi berpindah bagian',
      (WidgetTester tester) async {
    await tester.pumpWidget(NoorApp(api: apiTiruan()));

    expect(find.text('Beranda'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));

    // Pindah ke bagian Jadwal (penampung).
    await tester.tap(find.text('Jadwal').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Jadwal sholat metode Kemenag'), findsOneWidget);

    // Pindah ke Al-Qur'an: daftar surah termuat dari API tiruan.
    await tester.tap(find.text("Al-Qur'an").last);
    await tester.pumpAndSettle();
    expect(find.text('Al-Fatihah'), findsOneWidget);
    expect(find.text('Al-Baqarah'), findsOneWidget);
    expect(find.textContaining('Makkiyah • 7 ayat'), findsOneWidget);
  });
}
