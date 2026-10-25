# 📦 Patch Notes — SIMPanan v1.0.0

**Versi:** `1.0.0`  
**Build:** `1.0.0+1`  
**Tanggal Rilis:** 25 Oktober 2026  
**File APK:** [`SIMPanan-v1.0.0.apk`](./SIMPanan-v1.0.0.apk)

---

## 🚀 Ringkasan Rilis
Versi 1.0.0 adalah rilis perdana stabil untuk aplikasi **SIMPanan** (Aplikasi Pengelola Keuangan Pribadi Offline & Aman). Pembaruan ini memastikan pengguna mendapatkan pengalaman pencatatan keuangan harian yang bersih, aman, dan mudah disesuaikan sejak pertama kali dipasang.

---

## ✨ Fitur & Perubahan Terbaru

### 1. 🟢 Saldo Awal Kosongan (Clean Start)
- Aplikasi kini terbuka dalam kondisi bersih (*clean slate*):
  - **Saldo Awal:** `Rp0`
  - **Total Pemasukan:** `Rp0`
  - **Total Pengeluaran:** `Rp0`
  - **Riwayat Transaksi:** Kosong (`0 transaksi`)
- Tidak ada lagi data dummy / transaksi bawaan. Pengguna memulai pencatatan riil sesuai keuangannya sendiri.

### 2. 👤 Kustomisasi Profil Pengguna Lengkap
- Penambahan pengaturan data diri pengguna pada tab **Profil**:
  - **Nama Lengkap:** Dapat diedit dan disimpan secara aman.
  - **Umur:** Format angka tahun.
  - **Pekerjaan:** Pilihan dropdown fleksibel mencakup:
    - 🎓 **Pelajar**
    - 🎓 **Mahasiswa**
    - 💼 **Karyawan Swasta**
    - 🏛️ **PNS / ASN / BUMN**
    - 🏬 **Wiraswasta / Pengusaha**
    - 💻 **Freelancer / Kreator**
    - 🏠 **Ibu Rumah Tangga**
    - ✏️ **Lainnya** (dengan input teks kustom)
- Avatar profil dinamis dengan inisial nama dan lencana ikon pekerjaan.
- Opsi **Kosongkan Semua Transaksi** jika ingin mereset data sewaktu-waktu.

### 3. 🎯 Tombol Plus (+) di Bawah Presisi di Tengah
- Struktur tata letak `BottomAppBar` diperbarui menggunakan sistem *symmetrical dual-expanded container*.
- Tombol aksi mengambang (*Floating Action Button*) kini 100% presisi dan tepat di sumbu tengah (*center*) layar ponsel, memberikan estetika modern dan kenyamanan akses satu tangan.

### 4. 🏷️ Header Resmi "SIMPanan" & Dukungan Logo
- Header aplikasi pada tab Beranda kini menampilkan nama **SIMPanan**.
- Integrasi aset logo aplikasi di `assets/images/logo.png` dengan visual pig-wallet modern dan *fallback safe*.
- Indikator status keamanan lokal **"Offline Safe"**.

### 5. 🔒 Keamanan & Offline SQLite
- 100% penyimpanan data lokal perangkat menggunakan SQLite (`simpanan.db`).
- Data sensitif dan preferensi dilindungi enkripsi Android Keystore.
- Bebas dari pengiriman data ke server luar (*zero tracking*).

---

## 📥 Panduan Unduh & Pemasangan APK
1. Unduh file **[`SIMPanan-v1.0.0.apk`](./SIMPanan-v1.0.0.apk)**.
2. Buka file APK di ponsel Android Anda.
3. Jika muncul peringatan keamanan *"Install from Unknown Sources"*, izinkan untuk pengelola berkas atau browser Anda.
4. Klik **Install** dan buka aplikasi **SIMPanan**.

---

*SIMPanan — Catat rapi, hemat pasti, aman tersimpan.*
