// Uji unit parsing model Surah dari JSON Quran.com API v4.

import 'package:flutter_test/flutter_test.dart';
import 'package:noor/domain/surah.dart';

void main() {
  test('Surah.dariJson memetakan field dengan benar', () {
    final s = Surah.dariJson({
      'id': 36,
      'name_simple': 'Ya-Sin',
      'name_arabic': 'يس',
      'translated_name': {'name': 'Yasin'},
      'verses_count': 83,
      'revelation_place': 'makkah',
    });
    expect(s.nomor, 36);
    expect(s.namaLatin, 'Ya-Sin');
    expect(s.namaArab, 'يس');
    expect(s.arti, 'Yasin');
    expect(s.jumlahAyat, 83);
    expect(s.makkiyah, isTrue);
  });

  test('Surah madinah bukan makkiyah', () {
    final s = Surah.dariJson({
      'id': 2,
      'name_simple': 'Al-Baqarah',
      'name_arabic': 'البقرة',
      'translated_name': {'name': 'Sapi Betina'},
      'verses_count': 286,
      'revelation_place': 'madinah',
    });
    expect(s.makkiyah, isFalse);
  });
}
