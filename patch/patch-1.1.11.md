# 🚀 Catatan Rilis Patch 1.1.11 — SIMPanan

**Versi:** `1.1.11` (Build `1.1.11+12`)  
**Tanggal Rilis:** 25 Oktober 2026  
**Status Rilis:** Rilis Stabil Resmi (Optimalisasi Tab Animasi & Crop Foto Profil)  
**File APK:** [`patch/SIMPanan-v1.1.11.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.1.11.apk)

---

## 🎯 Ringkasan Pembaruan (Release Summary)

Patch **v1.1.11** menghadirkan penyempurnaan menyeluruh pada interaksi pengguna:
1. **Perbaikan & Animasi Segmented Tab "Transaksi Hari Ini":** Menghilangkan masalah tab yang mengecil atau memaksa layar bergeser/scroll saat beralih filter (*Semua / Pemasukan / Pengeluaran*). Kini tab memiliki ukuran proporsional tetap dengan indikator pill putih yang meluncur halus (*smooth sliding pill*).
2. **Layar Crop Foto Profil Interaktif (Tanpa Lag):** Saat memilih foto profil dari Kamera atau Galeri, pengguna dapat memposisikan, memperbesar/memperkecil (*pinch to zoom* 1x hingga 4.5x), dan memutar foto 90° dengan performa 60/90/120/144Hz yang bebas lag (*zero lag*).
3. **Restorasi Catatan Rilis Awal (`patch-1.0.0.md`):** Mengembalikan dokumentasi rilis perdana untuk menjaga integritas riwayat proyek.
4. **Pembatasan Akses Repositori Pribadi:** Menghapus instruksi eksekusi desktop/PC publik di `README.md` guna menegaskan bahwa kode sumber bersifat eksklusif untuk pemilik/pengembang (*author only*).

---

## ✨ Fitur & Peningkatan Detail

### 1. 🔘 Segmented Control Transaksi dengan Sliding Pill Halus
- **Ukuran Tab Proporsional & Tetap:** Ketiga tab (*Semua, Pemasukan, Pengeluaran*) dibagi dengan ukuran matematis yang sama persis (`availableWidth / 3`). Tab tidak lagi mengecil atau berubah ukuran saat salah satu filter dipilih.
- **Indikator Meluncur (*AnimatedPositioned*):** Menggunakan kurva `Curves.easeOutCubic` berdurasi 260ms sehingga pill seleksi bergerak mulus.
- **Transisi Konten Stabil (*AnimatedSize* & *AnimatedSwitcher*):** Mengatur `minHeight: 140` pada kontainer daftar transaksi sehingga perpindahan antara filter yang memiliki catatan dan yang kosong tidak lagi memicu sentakan/scroll mendadak pada layar.

### 2. ✂️ Fitur Crop Foto Profil Native Tanpa Lag (`PhotoCropScreen`)
- Dijalankan langsung pada render tree Flutter tanpa memanggil external Android Activity lawas yang lambat/berkedip.
- Mendukung layar *high refresh rate* 60Hz, 90Hz, 120Hz, dan 144Hz.
- Fitur interaktif:
  - Lingkaran crop overlay transparan berbingkai aksen hijau SIMPanan.
  - Rotasi foto 90 derajat dengan tombol sekali sentuh.
  - Reset transformasi ke posisi awal.
  - Tombol **Gunakan** yang mengekspor hasil crop berkualitas tinggi secara instan.

### 3. 📜 Pembaruan Riwayat Patch
- Berkas `patch-1.0.0.md` tetap dipertahankan sebagai arsip sejarah rilis awal aplikasi.
- Hanya berkas binary APK versi lawas yang dihapus agar ukuran repositori tetap efisien dan pengguna selalu mendapatkan versi APK termutakhir `SIMPanan-v1.1.11.apk`.

---

## 📲 Unduh Aplikasi (Direct Download)

Tautan langsung (*direct stream download*) otomatis mengunduh APK tanpa membuka halaman baru:

- 🚀 **[⬇️ Unduh SIMPanan v1.1.11 APK (Direct Download Otomatis)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.1.11.apk)**
- 🔗 **[Link Mirror GitHub Raw](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.1.11.apk)**

---

*Hak Cipta © 2026 SIMPanan — Catatan Keuangan Pribadi Offline & Aman.*
