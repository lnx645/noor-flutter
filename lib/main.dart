import 'package:flutter/material.dart';

/// Noor — Al-Qur'an & Ibadah (versi Flutter, native).
///
/// Fase 0: kerangka aplikasi — tema merek, navigasi bawah, dan halaman
/// penampung per bagian. Fitur diisi gelombang demi gelombang mengikuti
/// peta paritas versi web (lihat README & repo lnx645/quran-app).
void main() {
  runApp(const NoorApp());
}

/// Warna merek Noor (selaras versi web): hijau zamrud tua + gading.
class WarnaNoor {
  static const zamrud = Color(0xFF0B5345);
  static const zamrudTerang = Color(0xFF117A65);
  static const emas = Color(0xFFC9A227);
  static const gading = Color(0xFFFDFBF5);
}

class NoorApp extends StatelessWidget {
  const NoorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final skema = ColorScheme.fromSeed(
      seedColor: WarnaNoor.zamrud,
      brightness: Brightness.light,
    );
    return MaterialApp(
      title: 'Noor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: skema.copyWith(surface: WarnaNoor.gading),
        scaffoldBackgroundColor: WarnaNoor.gading,
        appBarTheme: const AppBarTheme(
          backgroundColor: WarnaNoor.zamrud,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          indicatorColor: Color(0xFFD5E8E2),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: WarnaNoor.zamrud,
          brightness: Brightness.dark,
        ),
      ),
      home: const KerangkaUtama(),
    );
  }
}

class Bagian {
  const Bagian(this.label, this.ikon, this.keterangan);
  final String label;
  final IconData ikon;
  final String keterangan;
}

const daftarBagian = <Bagian>[
  Bagian('Beranda', Icons.home_rounded,
      'Ayat & hadits harian, kartu streak, dan jalan pintas ibadah.'),
  Bagian("Al-Qur'an", Icons.menu_book_rounded,
      'Mushaf 114 surah: teks Utsmani, terjemahan Kemenag, audio dengan penanda kata, penanda & terakhir dibaca.'),
  Bagian('Jadwal', Icons.schedule_rounded,
      'Jadwal sholat metode Kemenag, hitung mundur, pengingat adzan & ibadah, kalender Hijriah.'),
  Bagian('Menu', Icons.grid_view_rounded,
      'Seluruh fitur: dzikir, doa & Hisnul Muslim, panduan ibadah, kalkulator fikih, masjid terdekat, Mode Anak, dan lainnya.'),
];

class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});

  @override
  State<KerangkaUtama> createState() => _KerangkaUtamaState();
}

class _KerangkaUtamaState extends State<KerangkaUtama> {
  int _aktif = 0;

  @override
  Widget build(BuildContext context) {
    final bagian = daftarBagian[_aktif];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noor — Al-Qur\'an & Ibadah'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(bagian.ikon, size: 72, color: WarnaNoor.zamrud),
              const SizedBox(height: 16),
              Text(
                bagian.label,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: WarnaNoor.zamrud,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                bagian.keterangan,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              const Chip(
                avatar: Icon(Icons.construction_rounded, size: 16),
                label: Text('Fase 0 — kerangka aplikasi'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _aktif,
        onDestinationSelected: (i) => setState(() => _aktif = i),
        destinations: [
          for (final b in daftarBagian)
            NavigationDestination(icon: Icon(b.ikon), label: b.label),
        ],
      ),
    );
  }
}
