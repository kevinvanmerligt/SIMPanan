# 🚀 Catatan Rilis Patch 1.2.2 — SIMPanan

**Versi:** `1.2.2`  
**Tanggal Rilis:** 26 Oktober 2026  
**Status Rilis:** Rilis Stabil Resmi (Dukungan Tema Terang/Gelap/Sistem, Palet Hijau Adaptif, & Kompresi Ukuran APK)  
**File APK:** [`patch/SIMPanan-v1.2.2.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.2.apk)

---

## 🎯 Ringkasan Pembaruan (Release Summary)

Pembaruan **Patch v1.2.2** membawa peningkatan besar dalam fleksibilitas visual, efisiensi ukuran berkas aplikasi, dan standardisasi penomoran versi:

1. **🌓 Mesin Tema Dinamis (Sistem / Terang / Gelap):** Pengguna kini dapat memilih mode tema tampilan aplikasi sesuai kebutuhan melalui halaman Profil. Mendukung penyesuaian otomatis dengan tema perangkat pengguna (*System Default*), mode Terang (*Light Mode*), atau mode Gelap (*Dark Mode*). Pilihan tema tersimpan secara persisten melalui `SharedPreferences`.
2. **🌿 Palet Warna Hijau Adaptif (Lebih Terang di Tema Gelap, Lebih Gelap di Tema Terang):**
   - **Pada Tema Terang:** Warna hijau utama disetel menjadi **lebih gelap & *deep*** (`#094A29`) guna menghasilkan kontras tajam, keterbacaan prima, dan nuansa mewah di atas latar putih bersih.
   - **Pada Tema Gelap:** Warna hijau utama bertransformasi menjadi **lebih cerah & bercahaya (*vibrant emerald-mint*)** (`#2BD980`) sehingga elemen penting tampak jelas, hidup (*pops*), dan ramah di mata saat digunakan di lingkungan redup.
3. **⚡ Kompresi Ukuran APK Drastis (Dari ~53 MB Turun Menjadi ~20-25 MB):** Mengaktifkan optimasi R8 *code minification*, *resource shrinking*, dan penyaringan arsitektur native ARM ponsel nyata (`arm64-v8a` & `armeabi-v7a`), memangkas lebih dari 50% ukuran APK tanpa mengurangi fitur apa pun.
4. **🔢 Standardisasi Versi Bersih (Tanpa Tanda `+`):** Menghilangkan sufiks nomor *build* (`+...`) pada seluruh dokumentasi rilis dan `README.md` sehingga penomoran versi bersih sesuai rilis `1.2.2`.

---

## ✨ Fitur & Peningkatan Detail

### 1. 🌓 Pengaturan Tema Lengkap di Halaman Profil
- **3 Mode Pilihan Interaktif:**
  - 📱 **Sistem (Device):** Mengikuti setelan tema ponsel secara *realtime* (otomatis beralih jika OS mengubah mode gelap/terang).
  - ☀️ **Terang (Light):** Memaksa tema terang dengan palet hijau gelap elegan.
  - 🌙 **Gelap (Dark):** Memaksa tema gelap dengan palet hijau cerah beraksen neon-mint.
- **Micro-Interaction Halus:** Kartu pemilihan tema dengan indikator visual dinamis dan teks penjelasan fungsi palet warna.
- **Penyimpanan Lokal:** Pilihan tema tersimpan di perangkat sehingga tetap aktif setelah aplikasi ditutup dan dibuka kembali.

### 2. 🎨 Re-engineering Desain Seluruh Layar (Dark & Light Mode Ready)
- Seluruh komponen (Header SIMPanan, Kartu Hero Saldo, Segmented Pill Transaksi Hari Ini, Grafik 7 Hari, Form Profil, Pencarian Riwayat, Laporan Pengeluaran, dan Modal Pencatatan Transaksi) telah dioptimalkan secara menyeluruh untuk mode Gelap dan Terang.
- Menggunakan skema warna kontekstual (`AppColors.of(context)` / `context.colors`) yang bereaksi instan tanpa perlu memuat ulang aplikasi.

### 3. 📦 Optimasi Ukuran Berkas APK (~20-25 MB)
- Mengaktifkan `isMinifyEnabled = true` dan `isShrinkResources = true` pada Gradle Release Build.
- Menerapkan aturan `proguard-rules.pro` untuk menjaga kestabilan plugin lokal (biometrik, SQLite, flutter_secure_storage, displaymode).
- Menghilangkan *engine binary* x86/x86_64 emulator yang memakan puluhan megabyte, menyisakan pustaka native ARM murni yang digunakan pada 100% ponsel Android nyata.

---

## 📲 Unduh Berkas APK (Direct Download)

Tautan langsung (*direct stream download*) otomatis mengunduh APK tanpa dialihkan ke halaman lain:

- 🚀 **[⬇️ Unduh SIMPanan v1.2.2 APK (Direct Download Otomatis)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.2.apk)**
- 🔗 **[Link Mirror GitHub Raw](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.2.2.apk)**

---

*Hak Cipta © 2026 SIMPanan — Catatan Keuangan Pribadi Offline & Aman.*
