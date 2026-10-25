# 💰 SIMPanan — Catatan Keuangan Pribadi Offline & Aman

<p align="center">
  <img src="assets/images/logo.png" alt="SIMPanan Logo" width="120" style="border-radius: 24px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);" />
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.47.7-blue.svg?logo=flutter" alt="Flutter" /></a>
  <a href="https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.1.11.apk" download="SIMPanan-v1.1.11.apk"><img src="https://img.shields.io/badge/Platform-Android%20APK-green.svg?logo=android" alt="Platform" /></a>
  <a href="./patch/patch-1.1.11.md"><img src="https://img.shields.io/badge/Patch-v1.1.11-emerald.svg" alt="Patch Version" /></a>
  <a href="#dukungan-layar-60--90--120--144hz"><img src="https://img.shields.io/badge/Display-60--144Hz%20Smooth-9cf.svg" alt="High Refresh Rate" /></a>
  <a href="https://sqlite.org"><img src="https://img.shields.io/badge/Database-SQLite%20Offline-blueviolet.svg?logo=sqlite" alt="Database" /></a>
  <a href="#keamanan--privasi-100-offline"><img src="https://img.shields.io/badge/Security-Android%20Keystore%20Encrypted-success.svg" alt="Security" /></a>
</p>

**SIMPanan** adalah aplikasi pengelolaan keuangan harian yang dirancang dengan antarmuka modern, interaktif, **animasi super halus (*ultra-smooth*)**, dan berfokus penuh pada **keamanan privasi lokal 100% offline**. Seluruh data pengeluaran dan pemasukan Anda tersimpan langsung di perangkat pribadi tanpa memerlukan koneksi internet ataupun akun pihak ketiga.

---

## 📥 Download File APK (Langsung Download Tanpa Pindah Halaman)

Anda dapat langsung mengunduh dan memasang aplikasi **SIMPanan v1.1.11** di smartphone Android. Tautan di bawah telah dioptimasi dengan tautan langsung (*direct stream*): **begitu diklik, aplikasi langsung otomatis terunduh di HP/laptop Anda tanpa dialihkan ke halaman lain**.

<p align="center">
  <a href="https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.1.11.apk" download="SIMPanan-v1.1.11.apk">
    <img src="https://img.shields.io/badge/⬇️%20DOWNLOAD%20APK%20v1.1.11-KLIK%20LANGSUNG%20UNDUH-059669?style=for-the-badge&logo=android&logoColor=white" alt="Download Langsung SIMPanan APK" />
  </a>
</p>

### 🔗 Pilihan Tautan Unduh Langsung:
- 🚀 **[⬇️ Unduh SIMPanan v1.1.11 APK (Direct Download Otomatis)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.1.11.apk)**
- 🔗 **[Link Mirror Unduh GitHub Raw](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.1.11.apk)**

> **Informasi Berkas Rilis:**
> - **Nama Berkas:** `SIMPanan-v1.1.11.apk`
> - **Versi Patch:** `1.1.11 (Build 1.1.11+12)`
> - **Kategori:** Keuangan Pribadi / Finance Management
> - **Target OS:** Android 6.0+ (Marshmallow ke atas)
> - **Lokasi Berkas di Repositori:** [`patch/SIMPanan-v1.1.11.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.1.11.apk)

### 📲 Cara Install APK di HP Android:
1. Klik tombol hijau **[Download APK v1.1.11]** di atas. File akan langsung terunduh otomatis ke ponsel Anda.
2. Setelah unduhan selesai, buka berkas APK melalui panel notifikasi atau *Pengelola File / File Manager*.
3. Jika muncul dialog keamanan *"Aplikasi dari sumber tidak dikenal"* (*Install Unknown Apps*), berikan izin untuk browser / pengelola berkas Anda.
4. Tekan tombol **Install / Pasang**, lalu nikmati aplikasi **SIMPanan**!

---

## 📦 Informasi Patch Saat Ini: `Patch 1.1.11`

> 📄 Catatan rilis lengkap dan changelog tersedia di dokumen: **[`patch/patch-1.1.11.md`](./patch/patch-1.1.11.md)**

### ✨ Sorotan Pembaruan Patch 1.1.11:
- 🔘 **Segmented Control Tab Transaksi Halus & Proporsional:** Tab *Semua*, *Pemasukan*, dan *Pengeluaran* kini memiliki ukuran tetap proporsional dengan indikator sliding pill animasi halus (`Curves.easeOutCubic`, 260ms), tanpa mengecil tiba-tiba atau memaksa layar bergeser/scroll.
- ✂️ **Crop Foto Profil Interaktif Native (Tanpa Lag):** Memungkinkan pengguna memposisikan, memperbesar/memperkecil (*pinch to zoom* 1x - 4.5x), dan memutar foto 90° dengan lancar di layar 60/90/120/144Hz sebelum diterapkan sebagai foto profil.
- ⚡ **Dukungan Layar 60Hz, 90Hz, 120Hz, dan 144Hz:** Integrasi mode refresh rate tinggi (`flutter_displaymode`) sehingga semua pergerakan dan animasi terasa super mulus tanpa *stuttering* (*butter-smooth*).
- 🎬 **Animasi Halus Antar Halaman & Navigasi:** Perpindahan menu menggunakan sliding transition halus (`PageView` + `Curves.easeOutCubic`, 320ms) dan micro-interaction elastis pada navigasi bawah.
- 📊 **Pengeluaran 7 Hari Terakhir (Seminggu Penuh):** Grafik pengeluaran komprehensif 7 hari terakhir dengan label "Hari ini" dan animasi FlChart 450ms.
- 📜 **Integritas Arsip Rilis:** Mempertahankan riwayat catatan rilis awal (`patch-1.0.0.md`) dan menghapus binary APK versi lama.

---

## 📌 Riwayat Versi & Folder Patch

| Versi Patch | Tanggal Rilis | File APK | Ringkasan Utama | Dokumen Rilis |
| :---: | :---: | :---: | :--- | :---: |
| **`v1.1.11`** *(Terbaru)* | 25 Oktober 2026 | [⬇️ `SIMPanan-v1.1.11.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.1.11.apk) | Segmented tab animasi sliding pill tanpa jerking scroll, crop foto profil native tanpa lag 60-144Hz | [Baca Patch 1.1.11](./patch/patch-1.1.11.md) |
| **`v1.0.8`** *(Sebelumnya)* | 25 Oktober 2026 | *Telah diperbarui ke v1.1.11* | Dukungan 60/90/120/144Hz, transisi halaman halus, animasi navigasi interaktif, foto profil, grafik 7 hari | [Baca Patch 1.0.8](./patch/patch-1.0.8.md) |
| **`v1.0.3`** *(Arsip)* | 25 Oktober 2026 | *Telah digantikan ke v1.1.11* | Logo anime kosmik baru, direct APK download tanpa pindah halaman, hapus patokan saldo & keamanan profil, header di semua tabs | [Baca Patch 1.0.3](./patch/patch-1.0.3.md) |
| **`v1.0.0`** *(Rilis Perdana)* | 25 Oktober 2026 | *Telah digantikan ke v1.1.11* | Rilis perdana: Saldo awal 0, kustomisasi profil, tombol plus center, header dasar | [Baca Patch 1.0.0](./patch/patch-1.0.0.md) |

---

## ✨ Fitur-Fitur Utama

1. **📊 Hero Saldo Harian Realtime**
   - Menghitung sisa saldo harian secara otomatis dan transparan (**Pemasukan - Pengeluaran**).
   - Indikator total pemasukan dan total pengeluaran hari ini.
   - Penanda tanggal kalender lokal Indonesia.

2. **⚡ Catat Cepat (Income & Expense)**
   - Modal pencatatan instan dengan pilihan kategori ikonik (*Makan & Minum, Belanja, Transportasi, Tagihan, Gaji, dll.*).
   - Numpad responsif dan otomatis tersimpan ke basis data lokal dalam hitungan detik.

3. **📈 Grafik Pengeluaran 7 Hari Terakhir (Seminggu Penuh)**
   - Visualisasi grafik batang interaktif yang halus (*Powered by FlChart*).
   - Mengetahui tren dan akumulasi pengeluaran harian pengguna selama 7 hari berturut-turut.

4. **📸 Profil Pengguna & Foto Profil Kustom (Crop Tanpa Lag)**
   - Unggah foto profil langsung dari Kamera atau Galeri ponsel dengan tool crop interaktif native 60-144Hz.
   - Kustomisasi nama, umur, dan pekerjaan (dengan opsi custom job).

5. **🔍 Riwayat & Pencarian Fleksibel**
   - Filter transaksi: *Semua*, *Pemasukan*, dan *Pengeluaran* dengan segmented control animasi sliding pill.
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
│   │       ├── app_header.dart         # Header terpusat untuk semua tabs navigasi (v1.1.11)
│   │       └── fade_slide_entrance.dart # Widget animasi entrance halus 60-144Hz
│   ├── data\                   # Model transaksi, kategori, & repositori profil (avatar path)
│   ├── features\
│   │   ├── beranda\            # Beranda dengan AppHeader, Hero Card, Grafik 7 Hari
│   │   │   └── widgets\
│   │   │       └── transaksi_hari_ini_list.dart # Segmented control sliding pill animasi
│   │   ├── catat_transaksi\    # Modal sheet catat pengeluaran & pemasukan
│   │   ├── laporan\            # Laporan rincian per kategori dengan AppHeader
│   │   ├── navigation\         # Bottom bar dengan animasi interaktif & PageView
│   │   ├── profil\             # Form profil, selector foto profil (kamera/galeri), & AppHeader
│   │   │   └── screens\
│   │   │       └── photo_crop_screen.dart # Layar crop foto profil interaktif tanpa lag
│   │   └── riwayat\            # Riwayat & pencarian transaksi dengan AppHeader
│   ├── providers\              # FinanceProvider state management (7 hari pengeluaran)
│   ├── app.dart
│   └── main.dart               # High refresh rate initialization (60/90/120/144Hz)
├── patch\                      # Folder Patch & File Rilis GitHub
│   ├── README.md               # Indeks seluruh patch rilis
│   ├── patch-1.1.11.md         # Detail catatan rilis Patch 1.1.11
│   ├── patch-1.0.8.md          # Catatan rilis Patch 1.0.8
│   ├── patch-1.0.3.md          # Catatan rilis Patch 1.0.3
│   ├── patch-1.0.0.md          # Arsip catatan rilis Patch 1.0.0 (Rilis Perdana)
│   └── SIMPanan-v1.1.11.apk    # File APK rilis v1.1.11 (direct download siap pakai)
├── pubspec.yaml
└── README.md                   # Dokumentasi utama proyek
```

---

## 🔒 Akses Proyek & Repositori Pribadi

> [!IMPORTANT]
> **PEMBERITAHUAN:** Proyek dan repositori kode sumber ini bersifat **pribadi dan eksklusif untuk pemilik/pengembang (*Author Only*)**.
> 
> Penggunaan, kloning, atau eksekusi kode sumber melalui komputer/perangkat lain tidak didukung dan tidak diizinkan untuk umum. Pengguna umum hanya dapat menggunakan dan menjalankan aplikasi resmi di smartphone Android melalui berkas rilis APK yang telah disediakan pada bagian unduhan di atas.

---

## 📄 Lisensi
Hak Cipta © 2026 SIMPanan. Dibuat untuk pengelolaan keuangan pribadi yang sederhana, rapi, dan aman.
