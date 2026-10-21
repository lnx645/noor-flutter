/// Model surah (bab Al-Qur'an) — selaras data Quran.com API v4 `/chapters`.
class Surah {
  const Surah({
    required this.nomor,
    required this.namaLatin,
    required this.namaArab,
    required this.arti,
    required this.jumlahAyat,
    required this.tempatTurun,
  });

  final int nomor;
  final String namaLatin;
  final String namaArab;
  final String arti;
  final int jumlahAyat;
  final String tempatTurun; // 'makkah' | 'madinah'

  bool get makkiyah => tempatTurun == 'makkah';

  factory Surah.dariJson(Map<String, dynamic> json) {
    return Surah(
      nomor: json['id'] as int,
      namaLatin: (json['name_simple'] ?? '') as String,
      namaArab: (json['name_arabic'] ?? '') as String,
      arti: (json['translated_name']?['name'] ?? '') as String,
      jumlahAyat: (json['verses_count'] ?? 0) as int,
      tempatTurun: (json['revelation_place'] ?? '') as String,
    );
  }
}
