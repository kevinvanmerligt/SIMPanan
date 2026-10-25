# 💰 SIMPanan — Catatan Keuangan Pribadi Offline & Aman

[![Flutter](https://img.shields.io/badge/Flutter-3.47.7-blue.svg?logo=flutter)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20APK-green.svg?logo=android)](./patch/SIMPanan-v1.0.0.apk)
[![Patch Version](https://img.shields.io/badge/Patch-v1.0.0-emerald.svg)](./patch/patch-1.0.0.md)
[![Database](https://img.shields.io/badge/Database-SQLite%20Offline-blueviolet.svg?logo=sqlite)](https://sqlite.org)
[![Security](https://img.shields.io/badge/Security-Android%20Keystore%20Encrypted-success.svg)](#keamanan--privasi)

**SIMPanan** adalah aplikasi pengelolaan keuangan harian yang dirancang dengan antarmuka modern, interaktif, dan berfokus penuh pada **keamanan privasi lokal 100% offline**. Seluruh data pengeluaran dan pemasukan Anda tersimpan di perangkat pribadi tanpa memerlukan internet ataupun akun pihak ketiga.

---

## 📥 Download File APK (Siap Pakai)

Anda dapat langsung mengunduh dan memasang aplikasi **SIMPanan** di smartphone Android:

### 🔗 **[Unduh SIMPanan v1.0.0 APK (Klik di Sini)](./patch/SIMPanan-v1.0.0.apk)**

> **Informasi File Rilis:**
> - **Nama Berkas:** `SIMPanan-v1.0.0.apk`
> - **Versi Patch:** `1.0.0 (Release 1.0.0+1)`
> - **Kategori:** Keuangan Pribadi / Finance
> - **Target OS:** Android 6.0+ (Marshmallow ke atas)
> - **Lokasi Folder:** [`patch/SIMPanan-v1.0.0.apk`](./patch/SIMPanan-v1.0.0.apk)

### 📲 Cara Install APK di HP Android:
1. Klik tautan unduh [**`SIMPanan-v1.0.0.apk`**](./patch/SIMPanan-v1.0.0.apk).
2. Setelah unduhan selesai, buka berkas APK dari bilah notifikasi atau *Pengelola File / File Manager*.
3. Jika muncul dialog keamanan *"Aplikasi dari sumber tidak dikenal"* (*Install Unknown Apps*), berikan izin untuk browser / pengelola berkas Anda.
4. Tekan tombol **Install / Pasang**, lalu buka aplikasi **SIMPanan**!

---

## 📦 Informasi Patch Saat Ini: `Patch 1.0.0`

> 📄 Catatan rilis lengkap dan changelog tersedia di dokumen: **[`patch/patch-1.0.0.md`](./patch/patch-1.0.0.md)**

### Sorotan Pembaruan Patch 1.0.0:
- 🟢 **Saldo Awal Bersih (Kosongan):** Memulai aplikasi dengan saldo Rp0 dan riwayat transaksi kosong, tanpa transaksi dummy.
- 👤 **Kustomisasi Profil Pengguna:**
  - Menampilkan Nama, Umur, dan Pekerjaan.
  - Pilihan pekerjaan mencakup: **Pelajar**, **Mahasiswa**, **Karyawan Swasta**, **PNS / ASN / BUMN**, **Wiraswasta / Pengusaha**, **Freelancer / Kreator**, **Ibu Rumah Tangga**, atau opsi **Lainnya**.
  - Avatar dinamis dengan badge ikon sesuai bidang profesi Anda.
- 🎯 **Tombol Plus (+) Navigasi Presisi di Tengah:** Tata letak Floating Action Button (FAB) di bottom navigation bar kini sejajar 100% di tengah layar ponsel.
- 🏷️ **Header & Identitas "SIMPanan":** Header modern dengan nama **SIMPanan**, logo aplikasi, dan indikator status **Offline Safe**.
- 📁 **Sistem Folder Patch:** Folder `patch/` khusus untuk menyimpan changelog dan arsip file APK setiap kali melakukan update ke GitHub.

---

## ✨ Fitur-Fitur Utama

1. **📊 Hero Saldo Harian**
   - Menghitung sisa saldo harian secara otomatis (*Realtime Balance*).
   - Indikator total pemasukan dan total pengeluaran hari ini.
   - Penanda tanggal kalender Indonesia.

2. **⚡ Catat Cepat (Income & Expense)**
   - Modal pencatatan cepat dengan pilihan kategori ikonik (*Makan & Minum, Belanja, Transportasi, Tagihan, Gaji, dll.*).
   - Otomatis tersimpan ke basis data lokal.

3. **📈 Grafik Pengeluaran 6 Hari Terakhir**
   - Visualisasi grafik batang interaktif (*Powered by FlChart*).
   - Mengetahui tren dan akumulasi pengeluaran harian.

4. **🔍 Riwayat & Filter Fleksibel**
   - Filter transaksi: *Semua*, *Pemasukan*, dan *Pengeluaran*.
   - Pencarian instan riwayat transaksi berdasarkan nama atau kategori.
   - Opsi hapus transaksi per item.

5. **🥧 Laporan Pengeluaran per Kategori**
   - Rangkuman total seluruh pengeluaran.
   - Progress bar persentase per kategori pengeluaran.

6. **🔒 Keamanan & Privasi 100% Offline**
   - Database SQLite lokal di perangkat (`simpanan.db`).
   - Preferensi terlindungi Android Keystore.
   - Tanpa analitik pelacak, tanpa server eksternal, dan tanpa iklan.

---

## 🗂️ Struktur Folder Proyek

```text
c:\SIMPanan\
├── android\                    # Android native configuration & wrapper
├── assets\
│   └── images\
│       └── logo.png            # Logo resmi aplikasi SIMPanan
├── lib\
│   ├── core\                   # Tema, konstanta warna, utils format Rupiah/tanggal
│   ├── data\                   # Model transaksi, kategori, & repositori profil
│   ├── features\
│   │   ├── beranda\            # Header SIMPanan, Hero Card, Grafik 6 Hari
│   │   ├── catat_transaksi\    # Modal sheet catat pengeluaran & pemasukan
│   │   ├── laporan\            # Laporan rincian per kategori
│   │   ├── navigation\         # Bottom bar dengan FAB center docking
│   │   ├── profil\             # Pengaturan profil, nama, umur, pekerjaan, reset
│   │   └── riwayat\            # Riwayat & pencarian transaksi
│   ├── providers\              # FinanceProvider state management
│   ├── app.dart
│   └── main.dart
├── patch\                      # Folder Patch & File Rilis GitHub
│   ├── README.md               # Indeks seluruh patch rilis
│   ├── patch-1.0.0.md          # Detail catatan rilis Patch 1.0.0
│   └── SIMPanan-v1.0.0.apk     # File APK rilis v1.0.0 (siap unduh)
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
git clone https://github.com/username/SIMPanan.git
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
