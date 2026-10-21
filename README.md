# Noor — Al-Qur'an & Ibadah (Flutter)

Versi **native penuh** dari aplikasi Noor, ditulis ulang dengan Flutter.
Repo web (React + Capacitor) tetap hidup di
[lnx645/quran-app](https://github.com/lnx645/quran-app) dan melayani
[nurqalam.my.id](https://nurqalam.my.id); repo ini adalah penerusnya di
Android.

## Kontinuitas aplikasi

- **applicationId sama:** `com.noor.app`
- **Kunci tanda tangan rilis sama** dengan versi sebelumnya
  (disimpan sebagai secret repo `RELEASE_KEYSTORE_B64`,
  `RELEASE_KEYSTORE_PASSWORD`, `RELEASE_KEY_ALIAS`)
- Di Play Store, aplikasi ini terbaca sebagai **pembaruan** aplikasi
  yang sama — bukan aplikasi baru.

## Target: paritas fitur dengan versi web

Acuan: `peta-fitur-lengkap-noor.md` di repo quran-app (Gelombang 1–8):

- Mushaf 114 surah (Utsmani, latin, terjemahan Kemenag), audio + penanda
  kata/ayat, mode hafalan, tafsir, tajwid berwarna, pencarian global,
  bookmark + catatan, terakhir dibaca
- Jadwal sholat (Kemenag) + hitung mundur, pengingat native (adzan,
  dzikir pagi/petang, target baca, tahajud, puasa sunnah H-1), kalender
  Hijriah + konverter
- Kiblat, masjid terdekat (Overpass/Photon), tasbih, dzikir pagi-petang,
  wirid ba'da sholat
- Doa & Hisnul Muslim (101), Arba'in (42), Riyadhus Shalihin (141/12 bab),
  kisah 25 nabi, sirah, sholawat, tahlil, ziarah kubur
- Panduan: wudhu, tayammum, sholat fardhu & sunnah, jenazah, puasa,
  haji & umrah, nikah, aqiqah/kurban, ruqyah, khutbah
- Kalkulator: zakat, waris (faraidh), fidyah, kafarat
- Muslimah: kalkulator haid/nifas (Syafi'i) + PIN
- Anak: hijaiyah + audio, Iqro 1–6 + audio Jilid 1, doa anak
- Personal: profil keluarga lokal, mutaba'ah, tracker sholat & khatam,
  qadha/utang puasa, sedekah, tabungan qurban, jurnal syukur, streak &
  lencana, statistik
- Radio murottal, kuis Islami, tes baca (eksperimental), nama bayi,
  indeks tematik, ekspor/impor data (format kompatibel versi web)
- Tentang aplikasi + info dukungan DANA/GoPay

Sumber data sama dengan versi web: Quran.com API v4, Aladhan API,
OpenStreetMap (Overpass + Photon).

## Pengembangan

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Build rilis dilakukan **GitHub Actions** (`.github/workflows/`):

- Push ke `main` → CI: analyze + test + artifact APK debug
- Tag `v*` / dispatch → rilis: APK + AAB bertanda tangan kunci tetap,
  verifikasi sertifikat di CI, terbit sebagai GitHub Release
