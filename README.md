# 💰 SIMPanan — Catatan Keuangan Pribadi Offline & Aman

<p align="center">
  <img src="assets/images/logo.png" alt="SIMPanan Logo" width="120" style="border-radius: 24px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);" />
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.47.7-blue.svg?logo=flutter" alt="Flutter" /></a>
  <a href="https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.8.apk" download="SIMPanan-v1.0.8.apk"><img src="https://img.shields.io/badge/Platform-Android%20APK-green.svg?logo=android" alt="Platform" /></a>
  <a href="./patch/patch-1.0.8.md"><img src="https://img.shields.io/badge/Patch-v1.0.8-emerald.svg" alt="Patch Version" /></a>
  <a href="#dukungan-layar-60--90--120--144hz"><img src="https://img.shields.io/badge/Display-60--144Hz%20Smooth-9cf.svg" alt="High Refresh Rate" /></a>
  <a href="https://sqlite.org"><img src="https://img.shields.io/badge/Database-SQLite%20Offline-blueviolet.svg?logo=sqlite" alt="Database" /></a>
  <a href="#keamanan--privasi-100-offline"><img src="https://img.shields.io/badge/Security-Android%20Keystore%20Encrypted-success.svg" alt="Security" /></a>
</p>

**SIMPanan** adalah aplikasi pengelolaan keuangan harian yang dirancang dengan antarmuka modern, interaktif, **animasi super halus (*ultra-smooth*)**, dan berfokus penuh pada **keamanan privasi lokal 100% offline**. Seluruh data pengeluaran dan pemasukan Anda tersimpan langsung di perangkat pribadi tanpa memerlukan koneksi internet ataupun akun pihak ketiga.

---

## 📥 Download File APK (Langsung Download Tanpa Pindah Halaman)

Anda dapat langsung mengunduh dan memasang aplikasi **SIMPanan v1.0.8** di smartphone Android. Tautan di bawah telah dioptimasi dengan tautan langsung (*direct stream*): **begitu diklik, aplikasi langsung otomatis terunduh di HP/laptop Anda tanpa dialihkan ke halaman lain**.

<p align="center">
  <a href="https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.8.apk" download="SIMPanan-v1.0.8.apk">
    <img src="https://img.shields.io/badge/⬇️%20DOWNLOAD%20APK%20v1.0.8-KLIK%20LANGSUNG%20UNDUH-059669?style=for-the-badge&logo=android&logoColor=white" alt="Download Langsung SIMPanan APK" />
  </a>
</p>

### 🔗 Pilihan Tautan Unduh Langsung:
- 🚀 **[⬇️ Unduh SIMPanan v1.0.8 APK (Direct Download Otomatis)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.8.apk)**
- 🔗 **[Link Mirror Unduh GitHub Raw](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.0.8.apk)**

> **Informasi Berkas Rilis:**
> - **Nama Berkas:** `SIMPanan-v1.0.8.apk`
> - **Versi Patch:** `1.0.8 (Build 1.0.8+9)`
> - **Kategori:** Keuangan Pribadi / Finance Management
> - **Target OS:** Android 6.0+ (Marshmallow ke atas)
> - **Lokasi Berkas di Repositori:** [`patch/SIMPanan-v1.0.8.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.8.apk)

### 📲 Cara Install APK di HP Android:
1. Klik tombol hijau **[Download APK v1.0.8]** di atas. File akan langsung terunduh otomatis ke ponsel Anda.
2. Setelah unduhan selesai, buka berkas APK melalui panel notifikasi atau *Pengelola File / File Manager*.
3. Jika muncul dialog keamanan *"Aplikasi dari sumber tidak dikenal"* (*Install Unknown Apps*), berikan izin untuk browser / pengelola berkas Anda.
4. Tekan tombol **Install / Pasang**, lalu nikmati aplikasi **SIMPanan**!

---

## 📦 Informasi Patch Saat Ini: `Patch 1.0.8`

> 📄 Catatan rilis lengkap dan changelog tersedia di dokumen: **[`patch/patch-1.0.8.md`](./patch/patch-1.0.8.md)**

### ✨ Sorotan Pembaruan Patch 1.0.8:
- ⚡ **Dukungan Layar 60Hz, 90Hz, 120Hz, dan 144Hz:** Integrasi mode refresh rate tinggi (`flutter_displaymode`) sehingga semua pergerakan dan animasi terasa super mulus tanpa *stuttering* (*butter-smooth*).
- 🎬 **Animasi Halus & Dinamis di Seluruh Aplikasi:**
  - **Transisi Halaman:** Berpindah tab menggunakan transisi sliding halus (`PageView` + `Curves.easeOutCubic`, durasi 320ms).
  - **Animasi Navigasi Bawah:** Ikon membesar elastis saat dipilih (`AnimatedScale` + `Curves.easeOutBack`), label bertransisi dinamis, serta pill highlight latar hijau tematik.
  - **Entrance Micro-Animations:** Setiap kartu (Hero Saldo, Catat Cepat, Grafik, Daftar Transaksi, Laporan, Riwayat, dan Profil) meluncur masuk dengan efek fade & slide bertahap.
- 📸 **Fitur Foto Profil Interaktif (Kamera & Galeri):** Pengguna kini dapat memotret foto dari kamera atau memilih dari galeri sebagai foto profil, serta terdapat opsi hapus foto profil. Berkas tersimpan permanen secara lokal.
- 📊 **Pengeluaran 7 Hari Terakhir (Seminggu Penuh):** Grafik pengeluaran ditingkatkan dari 6 hari menjadi 7 hari penuh (seminggu) lengkap dengan label "Hari ini" dan animasi batang (*FlChart swap animation* 450ms).
- 🧹 **Pembersihan Versi Lama:** Menghapus berkas patch lama (`patch-1.0.0.md`) dan APK versi sebelumnya agar repositori tetap rapi.

---

## 📌 Riwayat Versi & Folder Patch

| Versi Patch | Tanggal Rilis | File APK | Ringkasan Utama | Dokumen Rilis |
| :---: | :---: | :---: | :--- | :---: |
| **`v1.0.8`** *(Terbaru)* | 25 Oktober 2026 | [⬇️ `SIMPanan-v1.0.8.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.8.apk) | Dukungan 60/90/120/144Hz, transisi halaman halus, animasi navigasi interaktif, foto profil (kamera/galeri), dan grafik 7 hari | [Baca Patch 1.0.8](./patch/patch-1.0.8.md) |
| **`v1.0.3`** *(Sebelumnya)* | 25 Oktober 2026 | *Telah diperbarui ke v1.0.8* | Logo anime kosmik baru, direct APK download tanpa pindah halaman, hapus patokan saldo & keamanan profil, header di semua tabs | [Baca Patch 1.0.3](./patch/patch-1.0.3.md) |

---

## ✨ Fitur-Fitur Utama

1. **📊 Hero Saldo Harian Realtime**
   - Menghitung sisa saldo harian secara otomatis dan transparan.
   - Indikator total pemasukan dan total pengeluaran hari ini.
   - Penanda tanggal kalender lokal Indonesia.

2. **⚡ Catat Cepat (Income & Expense)**
   - Modal pencatatan instan dengan pilihan kategori ikonik (*Makan & Minum, Belanja, Transportasi, Tagihan, Gaji, dll.*).
   - Numpad responsif dan otomatis tersimpan ke basis data lokal dalam hitungan detik.

3. **📈 Grafik Pengeluaran 7 Hari Terakhir (Seminggu Penuh)**
   - Visualisasi grafik batang interaktif yang halus (*Powered by FlChart*).
   - Mengetahui tren dan akumulasi pengeluaran harian pengguna selama 7 hari berturut-turut.

4. **📸 Profil Pengguna & Foto Profil Kustom**
   - Unggah foto profil langsung dari Kamera atau Galeri ponsel.
   - Kustomisasi nama, umur, dan pekerjaan (dengan opsi custom job).

5. **🔍 Riwayat & Pencarian Fleksibel**
   - Filter transaksi: *Semua*, *Pemasukan*, dan *Pengeluaran*.
   - Pencarian instan riwayat transaksi berdasarkan nama transaksi atau kategori.

6. **🥧 Laporan Pengeluaran per Kategori**
   - Rangkuman total seluruh pengeluaran.
   - Progress bar persentase visual untuk setiap kategori pengeluaran.

7. **🔒 Keamanan & Privasi 100% Offline**
   - Database SQLite lokal di perangkat smartphone (`simpanan.db`).
   - Preferensi terlindungi Android Keystore.
   - Bebas pelacak data, tanpa analitik pihak ketiga, tanpa server luar, dan tanpa iklan.

---

## 🗂️ Struktur Folder Proyek

```text
c:\SIMPanan\
├── android\                    # Android native configuration, res/mipmap launcher icons
├── assets\
│   └── images\
│       └── logo.png            # Logo resmi aplikasi SIMPanan (Cosmic Vector)
├── lib\
│   ├── core\                   # Tema, AppColors, utils Rupiah/tanggal, SimpananAppHeader
│   │   └── widgets\
│   │       ├── app_header.dart         # Header terpusat untuk semua tabs navigasi (v1.0.8)
│   │       └── fade_slide_entrance.dart # Widget animasi entrance halus 60-144Hz
│   ├── data\                   # Model transaksi, kategori, & repositori profil (avatar path)
│   ├── features\
│   │   ├── beranda\            # Beranda dengan AppHeader, Hero Card, Grafik 7 Hari
│   │   ├── catat_transaksi\    # Modal sheet catat pengeluaran & pemasukan
│   │   ├── laporan\            # Laporan rincian per kategori dengan AppHeader
│   │   ├── navigation\         # Bottom bar dengan animasi interaktif & PageView
│   │   ├── profil\             # Form profil, selector foto profil (kamera/galeri), & AppHeader
│   │   └── riwayat\            # Riwayat & pencarian transaksi dengan AppHeader
│   ├── providers\              # FinanceProvider state management (7 hari pengeluaran)
│   ├── app.dart
│   └── main.dart               # High refresh rate initialization (60/90/120/144Hz)
├── patch\                      # Folder Patch & File Rilis GitHub
│   ├── README.md               # Indeks seluruh patch rilis
│   ├── patch-1.0.8.md          # Detail catatan rilis Patch 1.0.8
│   ├── patch-1.0.3.md          # Catatan rilis Patch 1.0.3
│   └── SIMPanan-v1.0.8.apk     # File APK rilis v1.0.8 (direct download siap pakai)
├── pubspec.yaml
└── README.md                   # Dokumentasi utama proyek
```

---

## 💻 Panduan Menjalankan dari Kode Sumber (Developer)

Jika ingin menjalankan atau mengembangkan aplikasi di komputer lokal:

### Prasyarat:
- [Flutter SDK](https://flutter.dev) (versi 3.13.0 ke atas)
- Java JDK 17+ & Android SDK
- VS Code / Android Studio dengan ekstensi Flutter & Dart

### Langkah-langkah:
```bash
# 1. Clone repository
git clone https://github.com/kevinvanmerligt/SIMPanan.git
cd SIMPanan

# 2. Ambil dependensi paket
flutter pub get

# 3. Jalankan aplikasi di emulator atau perangkat fisik
flutter run

# 4. Bangun file APK rilis
flutter build apk --release
```

---

## 📄 Lisensi
Hak Cipta © 2026 SIMPanan. Dibuat untuk pengelolaan keuangan pribadi yang sederhana, rapi, dan aman.
