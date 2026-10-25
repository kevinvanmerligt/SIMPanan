# 🚀 Catatan Rilis Patch 1.0.8 — SIMPanan

**Versi:** `1.0.8` (Build `1.0.8+9`)  
**Tanggal Rilis:** 25 Oktober 2026  
**Status Rilis:** Rilis Stabil Resmi (Fitur Animasi & Foto Profil)  
**File APK:** [`patch/SIMPanan-v1.0.8.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.8.apk)

---

## 🎯 Ringkasan Pembaruan (Release Summary)

Patch **v1.0.8** merupakan pembaruan besar yang berfokus pada peningkatan estetika visual, transisi animasi halus di seluruh antarmuka aplikasi, dukungan layar *high refresh rate* (60Hz, 90Hz, 120Hz, dan 144Hz), kemampuan mengunggah foto profil kustom (kamera/galeri), serta penyempurnaan grafik analitik pengeluaran menjadi 7 hari penuh (seminggu).

---

## ✨ Daftar Fitur & Pembaruan Utama

### 1. ⚡ Dukungan Layar High Refresh Rate (60Hz / 90Hz / 120Hz / 144Hz)
- Mengintegrasikan package `flutter_displaymode` untuk secara otomatis meminta mode refresh rate tertinggi yang didukung oleh layar perangkat pengguna (misal 90Hz, 120Hz, hingga 144Hz).
- Mengeliminasi pembatasan frame rate 60fps bawaan sistem Android sehingga setiap pergerakan animasi, pergantian halaman, dan gesekan terasa sangat mulus (*buttery smooth*).

### 2. 🎬 Animasi Halus & Dinamis di Seluruh Aplikasi
- **Transisi Pergantian Halaman (`PageView` + Curves.easeOutCubic):**
  - Menggantikan perpindahan tab kaku dengan animasi slide & fade yang halus berdurasi 320ms.
  - Berpindah tab dari Beranda, Laporan, Riwayat, hingga Profil kini memanjakan mata tanpa jeda kaku.
- **Micro-Interaction pada Bar Navigasi Bawah:**
  - Saat tab dipilih, ikon membesar secara elastis dengan kurva `Curves.easeOutBack`.
  - Terdapat pill highlight berlatar hijau lembut (`AppColors.primaryPillBg`) yang bertransisi halus saat tab berganti.
  - Teks label tab bertransisi warna dan bobot font (`FontWeight.w700`) secara dinamis.
- **Animasi Bertahap (`FadeSlideEntrance`):**
  - Kartu Hero Saldo, tombol Catat Cepat, Grafik 7 Hari, daftar transaksi, kartu laporan, dan seksi profil meluncur masuk dengan efek fade & slide bertahap (staggered delay).

### 3. 📸 Unggah & Kustomisasi Foto Profil (Kamera & Galeri)
- Pengguna kini tidak lagi hanya menggunakan inisial nama polos ("tidak polosan lagi").
- Menambahkan tombol edit foto profil interaktif dengan badge kamera pada avatar.
- Menu pemilihan sumber foto (*Bottom Sheet*):
  - 📷 **Ambil dari Kamera:** Memotret langsung menggunakan kamera ponsel.
  - 🖼️ **Pilih dari Galeri:** Memilih gambar tersimpan dari galeri perangkat.
  - 🗑️ **Hapus Foto Profil:** Mengembalikan tampilan avatar ke inisial nama.
- Berkas gambar foto profil disimpan secara permanen di direktori internal aplikasi (`getApplicationDocumentsDirectory`) dan path-nya tersimpan secara terenkripsi di `ProfileRepository` (`FlutterSecureStorage`).

### 4. 📊 Pengeluaran 7 Hari Terakhir (Seminggu Penuh)
- Mengubah rentang grafik pengeluaran dari 6 hari menjadi **7 hari terakhir** (seminggu penuh) agar data analitik lebih representatif, logis, dan tidak nanggung.
- Penanda batang hari ini bertuliskan label khusus **"Hari ini"** dengan warna hijau aksen utama.
- Animasi perpindahan batang grafik (*FlChart smooth swap duration* 450ms dengan kurva `Curves.easeOutCubic`).

### 5. 🧹 Pembersihan Arsip Versi Lama
- Menghapus berkas catatan rilis versi terdahulu (`patch-1.0.0.md`) dan berkas APK lama (`SIMPanan-v1.0.3.apk`) dari repositori agar struktur folder tetap bersih dan rapi.
- Memperbarui dokumentasi [`README.md`](../README.md) utama dan [`patch/README.md`](./README.md).

---

## 📲 Petunjuk Unduh & Pemasangan

Tautan langsung (*direct stream download*) dapat diakses tanpa dialihkan ke halaman preview:

- 🚀 **[⬇️ Unduh Langsung APK v1.0.8 (SIMPanan-v1.0.8.apk)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.8.apk)**
- 🔗 **[Link Mirror GitHub Raw](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.0.8.apk)**

---

## 📋 Detail Teknis Perubahan Kode

| Komponen / Berkas | Jenis Perubahan | Deskripsi |
| :--- | :---: | :--- |
| `pubspec.yaml` | **Modifikasi** | Naik versi ke `1.0.8+9`, menambahkan dependensi `image_picker` dan `flutter_displaymode`. |
| `android/app/src/main/AndroidManifest.xml` | **Modifikasi** | Menambahkan izin `CAMERA`, `READ_EXTERNAL_STORAGE`, dan `READ_MEDIA_IMAGES`. |
| `lib/main.dart` | **Modifikasi** | Mengaktifkan `FlutterDisplayMode.setHighRefreshRate()` pada peluncuran awal. |
| `lib/core/widgets/fade_slide_entrance.dart` | **Baru** | Widget animasi entrance halus berkinerja tinggi untuk layar 60/90/120/144Hz. |
| `lib/features/navigation/main_nav_screen.dart` | **Modifikasi** | Menggunakan `PageView` dengan transisi halus 320ms dan animasi interaktif pada nav item. |
| `lib/data/repositories/profile_repo.dart` | **Modifikasi** | Menambahkan dukungan `avatarPath` lokal pada `UserProfile` dan penyimpanan aman. |
| `lib/features/profil/screens/profil_screen.dart` | **Modifikasi** | Menambahkan selector foto profil (Kamera/Galeri/Hapus), avatar visual, dan versi 1.0.8. |
| `lib/providers/finance_provider.dart` | **Modifikasi** | Menghitung `last7DaysExpenses` dan `total7DaysExpense` (7 hari penuh). |
| `lib/features/beranda/widgets/grafik_enam_hari_card.dart` | **Modifikasi** | Memperbarui kartu grafik ke 7 hari dengan animasi perpindahan batang. |
| `lib/core/constants/app_strings.dart` | **Modifikasi** | Menambahkan string `pengeluaran7Hari`. |
| `lib/core/widgets/app_header.dart` | **Modifikasi** | Memperbarui badge versi default ke `v1.0.8`. |
| `patch/patch-1.0.0.md` & `patch/SIMPanan-v1.0.3.apk` | **Dihapus** | Menghapus arsip versi lama sesuai permintaan. |

---

*Hak Cipta © 2026 SIMPanan — Catatan Keuangan Pribadi Offline & Aman.*
