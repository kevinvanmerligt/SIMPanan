# 📋 Catatan Rilis & Patch Notes — SIMPanan v1.0.3

**Versi:** `1.0.3` (Build `1.0.3+4`)  
**Tanggal Rilis:** 25 Oktober 2026  
**Status:** Rilis Stabil (Production Release)  
**Tautan Unduh Langsung APK:** [SIMPanan-v1.0.3.apk (Direct Download)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.3.apk)  

---

## 🚀 Ringkasan Pembaruan Patch 1.0.3

Pembaruan **Patch 1.0.3** menghadirkan pembaruan identitas visual baru yang dipilih oleh pengguna, pengalaman pengunduhan langsung dari GitHub tanpa berpindah halaman, penyederhanaan UI dengan menghapus pengaturan saldo awal & seksi keamanan lokal yang berlebihan, serta penyeragaman header aplikasi di seluruh tab navigasi.

---

## 🎨 1. Logo Baru Resmi Aplikasi (Cosmic Anime Vector)
- **Identitas Baru:** Menggantikan logo placeholder lama dengan desain visual karakter anime kosmik bermahkota cincin planet dan aksen bintang.
- **Integrasi Penuh:**
  - Terpasang pada kartu header aplikasi di semua tab navigasi.
  - Diperbarui pada seluruh ukuran ikon peluncur sistem Android (*Launcher Mipmap*): `mdpi`, `hdpi`, `xhdpi`, `xxhdpi`, dan `xxxhdpi`.
  - Dilengkapi sistem *fallback graceful* jika aset dalam proses muat.

---

## 📥 2. Direct Download Link via GitHub (Tanpa Dialihkan Halaman)
- **Masalah Sebelumnya:** Ketika pengguna mengklik link APK pada README di GitHub, pengguna diarahkan masuk ke halaman blob viewer GitHub dan harus mengklik tombol unduh kembali.
- **Solusi di Patch 1.0.3:** Tautan unduhan kini menggunakan tautan `raw` / attachment stream:
  - `https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.3.apk`
  - Begitu tautan diklik, browser smartphone atau PC langsung memulai proses pengunduhan berkas APK secara otomatis tanpa meninggalkan halaman README.

---

## ✂️ 3. Penghapusan Fitur "Patokan Saldo Awal"
- Berdasarkan masukan pengguna, konsep "Patokan Saldo Awal" dihapus demi menjaga kejelasan dan transparansi pencatatan harian.
- **Perubahan Pada Antarmuka:**
  - Bagian form dan tombol *"Update Saldo Awal"* pada menu Profil telah ditiadakan.
  - Kartu Hero Saldo di Beranda kini berfokus menampilkan jumlah transaksi tercatat hari ini tanpa teks nominal patokan awal.
  - Perhitungan sisa saldo harian murni diperoleh dari: **Total Pemasukan - Total Pengeluaran**.

---

## 🧹 4. Pembersihan Menu Profil (Hapus Keamanan & Penyimpanan Lokal)
- Seksi *"Keamanan & Penyimpanan Lokal"* pada halaman Profil dihapus karena tidak esensial bagi pengguna harian.
- Halaman profil kini tampil jauh lebih rapi, elegan, dan fokus pada:
  1. Kartu identitas pengguna (Avatar dengan inisial nama & badge pekerjaan, nama, profesi, umur).
  2. Formulir pengubahan profil (Nama, Umur, Pekerjaan dropdown + isian custom).
  3. Informasi patch & versi aplikasi (`v1.0.3`).

---

## 📱 5. Header Aplikasi Seragam di Seluruh Tabs
- Menghadirkan komponen reusable `SimpananAppHeader` di seluruh 4 tab navigasi utama:
  - 🏠 **Beranda**
  - 📊 **Laporan**
  - 📅 **Riwayat**
  - 👤 **Profil**
- Menampilkan logo resmi terbaru, judul aplikasi **SIMPanan**, slogan **Kelola Keuangan Pribadi**, badge versi patch (`v1.0.3`), dan indikator status **Offline Safe**.
- Struktur modular memudahkan pengembang untuk memperbarui badge atau nomor patch di masa mendatang secara terpusat.

---

## 📦 Berkas Binary Rilis

| Nama Berkas | Ukuran | Format | Target Android | Lokasi Berkas |
| :--- | :---: | :---: | :---: | :--- |
| **`SIMPanan-v1.0.3.apk`** | ~50-55 MB | `.apk` (Release) | Android 6.0+ (API 23+) | [`patch/SIMPanan-v1.0.3.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.3.apk) |

---

## 📲 Cara Memasang Pembaruan:
1. Klik tautan [**Download SIMPanan v1.0.3 APK**](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.0.3.apk).
2. Tunggu unduhan hingga selesai pada bilah notifikasi ponsel.
3. Klik file APK yang baru diunduh dan pilih **Perbarui / Update Aplikasi**.
4. Semua data transaksi offline yang sudah ada di smartphone Anda tetap aman dan tidak akan hilang.
