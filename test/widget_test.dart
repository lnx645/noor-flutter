// Uji asap kerangka Fase 0: aplikasi tampil dengan navigasi bawah 4 bagian
// dan berpindah bagian saat tab diketuk.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:noor/main.dart';

void main() {
  testWidgets('Kerangka utama tampil & navigasi berpindah bagian',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NoorApp());

    // Bagian awal: Beranda.
    expect(find.text('Beranda'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(4));

    // Pindah ke bagian Jadwal.
    await tester.tap(find.text('Jadwal').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Jadwal sholat metode Kemenag'), findsOneWidget);

    // Pindah ke bagian Al-Qur'an.
    await tester.tap(find.text("Al-Qur'an").last);
    await tester.pumpAndSettle();
    expect(find.textContaining('Mushaf 114 surah'), findsOneWidget);
  });
}
