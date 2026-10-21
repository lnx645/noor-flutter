import 'package:flutter/material.dart';

import '../../data/quran_api.dart';
import '../../domain/surah.dart';

/// Daftar 114 surah — pintu masuk mushaf (Gelombang 1).
class HalamanDaftarSurah extends StatefulWidget {
  const HalamanDaftarSurah({super.key, required this.api});

  final QuranApi api;

  @override
  State<HalamanDaftarSurah> createState() => _HalamanDaftarSurahState();
}

class _HalamanDaftarSurahState extends State<HalamanDaftarSurah> {
  late Future<List<Surah>> _masaDepan;

  @override
  void initState() {
    super.initState();
    _masaDepan = widget.api.daftarSurah();
  }

  void _muatUlang() {
    setState(() {
      _masaDepan = widget.api.daftarSurah();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
      future: _masaDepan,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off_rounded, size: 48),
                  const SizedBox(height: 12),
                  const Text('Tidak dapat memuat daftar surah.\nPeriksa koneksi internet.',
                      textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: _muatUlang,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        }
        final daftar = snapshot.data ?? const <Surah>[];
        return ListView.separated(
          itemCount: daftar.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final s = daftar[i];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFD5E8E2),
                child: Text('${s.nomor}',
                    style: const TextStyle(
                        color: Color(0xFF0B5345), fontWeight: FontWeight.bold)),
              ),
              title: Text(s.namaLatin,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(
                  '${s.makkiyah ? 'Makkiyah' : 'Madaniyah'} • ${s.jumlahAyat} ayat • ${s.arti}'),
              trailing: Text(s.namaArab,
                  style: const TextStyle(fontSize: 20),
                  textDirection: TextDirection.rtl),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Surah ${s.namaLatin} — halaman baca hadir di increment berikutnya.')),
                );
              },
            );
          },
        );
      },
    );
  }
}
