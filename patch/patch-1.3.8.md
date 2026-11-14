# 🚀 Catatan Rilis Patch 1.3.8 — SIMPanan

**Versi:** `1.3.8`  
**Tanggal Rilis:** 12 November 2026  
**Status Rilis:** Rilis Stabil Resmi (Total Pengeluaran di Atas, Pengelolaan Tabungan per Baris, Proteksi Transfer Saldo Anti-Minus, & Fitur Pelacakan Hutang)  
**File APK:** [`patch/SIMPanan-v1.3.8.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.3.8.apk)

---

## 🎯 Ringkasan Pembaruan (Release Summary)

Pembaruan **Patch v1.3.8** menghadirkan pembaruan fungsional mendalam yang berfokus pada akurasi finansial nyata, fleksibilitas laporan, serta pelacakan liabilitas dan hutang:

1. **📊 Rekonfigurasi Tata Letak Laporan Keuangan (Total Pengeluaran Teratas):**
   - **Total Seluruh Pengeluaran** kini diposisikan di urutan teratas pada tab Laporan, memudahkan pengguna melihat pengeluaran kumulatif dan rincian belanja per kategori secara langsung saat membuka tab laporan.
   - Dilengkapi diagram batang horizontal dengan animasi mulus berbasis persentase pengeluaran.

2. **🏦 Pengelolaan Kantong Tabungan Terpisah per Baris (Row-by-Row Management):**
   - Setiap kantong tabungan kini memiliki kartu baris mandiri (Baris 1, Baris 2, Baris 3, dst.) alih-alih disatukan dalam satu wadah.
   - Setiap baris tabungan menampilkan saldo aktif, rasio kontribusi terhadap total simpanan, progres terhadap target nominal, serta tombol pintas **Kelola** untuk melihat detail, setor cepat, atau tarik saldo.

3. **🛡️ Proteksi Transfer Saldo Anti-Minus (Transfer Real-World Balance Guard):**
   - Meniru sistem perbankan nyata: pengguna **tidak dapat memindahkan saldo melebihi uang yang tersedia di kantong asal**.
   - Dilengkapi validasi interaktif yang mendeteksi saldo tidak cukup, menampilkan pesan peringatan merah *"Saldo tidak mencukupi"*, dan menonaktifkan tombol transfer secara otomatis.
   - Dilengkapi shortcut *"Pindahkan Semua"* untuk memudahkan transfer seluruh saldo dalam satu ketukan.

4. **💳 Sistem Manajemen & Pencatatan Hutang (Debt / Liability Tracker):**
   - Fitur baru untuk mencatat kewajiban/hutang pinjaman (misal pinjaman teman, tagihan jatuh tempo, cicilan, atau paylater) lengkap dengan nominal, tanggal jatuh tempo, dan catatan keterangan.
   - **Dampak Finansial Nyata:** Hutang aktif langsung diperhitungkan ke dalam ringkasan harian. Beban hutang mengurangi pendapatan/saldo bersih harian dan dapat menampilkan saldo bernilai minus bila total hutang melebihi kas masuk.
   - Fitur **Bayar Hutang** fleksibel: pengguna dapat mencicil atau melunasi hutang dengan memilih kantong tabungan asal, yang secara otomatis membukukan transaksi pengeluaran dan memperbarui status lunas.

5. **🧹 Penyegaran & Tampilan Antarmuka Bersih:**
   - Menyederhanakan header aplikasi, splash screen, dan halaman profil untuk menyajikan antarmuka yang bersih, rapi, dan modern.

6. **📦 Binary APK Ringan & Terkompresi (~20-22 MB):**
   - Dioptimasi menggunakan compiler arm64-v8a native serta code shrinking ProGuard/R8 untuk menghasilkan berkas instalasi yang ramping, cepat diunduh, dan hemat memori pada smartphone Android.

---

## 📲 Unduh Berkas APK (Direct Download)

Tautan langsung (*direct stream download*) otomatis mengunduh APK tanpa dialihkan ke halaman lain:

- 🚀 **[⬇️ Unduh SIMPanan v1.3.8 APK (Direct Download Otomatis)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.3.8.apk)**
- 🔗 **[Link Mirror GitHub Raw](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.3.8.apk)**

---

*Hak Cipta © 2026 SIMPanan — Catatan Keuangan Pribadi.*

