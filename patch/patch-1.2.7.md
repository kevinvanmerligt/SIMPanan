# 🚀 Catatan Rilis Patch 1.2.7 — SIMPanan

**Versi:** `1.2.7`  
**Tanggal Rilis:** 26 Oktober 2026  
**Status Rilis:** Rilis Stabil Resmi (Animasi Masuk/Splash Lucu & Meriah, Perbaikan Bug Tombol Plus Melayang, & Floating In-App Notification)  
**File APK:** [`patch/SIMPanan-v1.2.7.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.7.apk)

---

## 🎯 Ringkasan Pembaruan (Release Summary)

Pembaruan **Patch v1.2.7** menghadirkan pengalaman visual yang jauh lebih hidup, ceria, dan interaktif ketika pengguna membuka aplikasi, sekaligus menuntaskan masalah visual layout saat menyimpan perubahan profil:

1. **✨ Animasi Masuk Aplikasi yang Halus, Meriah, dan Menggemaskan (Kawaii Splash Entrance Screen):**
   - Mengubah layar awal saat pengguna menekan dan masuk ke aplikasi. Tidak lagi sekadar menampilkan ikon statis atau langsung masuk mendadak.
   - Menghadirkan maskot celengan babi gemas kawaii dengan telinga yang bergoyang, pipi merona pink, dan mata berkedip yang hidup (`( • ‿ • )` ↔ `( ^ ‿ ^ )`).
   - Animasi koin emas melompat dan jatuh masuk ke dalam celengan dengan pantulan elastis (*spring bounce*).
   - Efek latar belakang meriah dengan 26 partikel bintang kilau emas (✨), gelembung mint, dan koin mikro yang melayang halus berkesinambungan (dioptimalkan untuk layar 60Hz, 90Hz, 120Hz, dan 144Hz).
   - Indikator progres halus dengan koin emas mini yang menggelinding di atas garis progres bar, disertai pesan status interaktif yang berganti manis (*Menghitung koin receh...* ➡️ *Merapikan dompet harian...* ➡️ *Menyiapkan catatan keuanganmu...* ➡️ *Siap! Selamat datang!*).
   - Transisi keluar super mulus (*seamless zoom & fade*) menuju menu utama.
   - Tersedia tombol **"Lewati"** di pojok kanan atas untuk akses cepat, serta tombol **"Putar Ulang Animasi (Splash)"** di menu Profil agar pengguna dapat menikmati animasi kapan pun.

2. **🛡️ Perbaikan Bug Tombol Plus Terangkat (Floating In-App Notification System):**
   - **Masalah Sebelumnya:** Saat menekan tombol *"Simpan Perubahan Profil"*, notifikasi status SnackBar bawaan Scaffold muncul di bagian bawah layar sehingga mendorong tombol tambah (`+` / Floating Action Button) terangkat keluar dari lekukan navigasi (*notch*).
   - **Solusi Patch 1.2.7:** Mengganti mekanisme SnackBar bawaan dengan sistem **Notifikasi Mengambang Murni (*Floating Notification / Toast Overlay*)**.
   - Notifikasi kini melayang anggun di bagian atas layar (*top floating pill*) dengan animasi meluncur halus, ikon badge centang hijau, efek bayangan lembut, dan auto-dismiss 2.8 detik.
   - Karena berjalan di atas layer `OverlayEntry`, Scaffold tidak lagi menggeser FloatingActionButton, sehingga **tombol plus (`+`) tetap kokoh, tenang, dan stabil di posisinya tanpa terangkat sedikit pun**!

3. **🔢 Standardisasi Versi Bersih 1.2.7:**
   - Pembaruan penomoran versi resmi ke `1.2.7` pada `pubspec.yaml`, `build.gradle.kts` (versionCode 17), `app_header.dart`, halaman profil, dan seluruh dokumentasi rilis.

---

## ✨ Fitur & Peningkatan Detail

### 1. 🐷 Layar Pembuka Animasi Lucu & Meriah (Splash Entrance Screen)
- **Komponen Visual Ceria:**
  - Maskot celengan hijau mint chubby dengan gradasi warna yang menyesuaikan tema (Light / Dark mode).
  - Animasi loop kedipan mata kawaii yang membuat aplikasi terasa hidup dan ramah.
  - Partikel partikel kilau emas dan mint yang melayang dinamis dengan pergerakan sinusoidal.
  - Koin mini yang berputar dan berjalan di atas progress bar pengisian.
- **Performa Tinggi:** Menggunakan `CustomPainter` dan kurva fisika `Curves.elasticOut` & `Curves.easeOutBack` yang berjalan sangat mulus di layar 60Hz hingga 144Hz tanpa lag.
- **Fitur Putar Ulang:** Pengguna dapat memutar ulang animasi pembuka kapan saja melalui tombol khusus di halaman **Profil** ➡️ **Animasi Pembuka Lucu**.

### 2. 🪶 Floating Notification Murni (Bebas Bug FAB Terangkat)
- **Desain Modern Floating Capsule:** Melayang di bagian atas layar dengan padding aman (*SafeArea*), sudut membulat 20px, dan border halus.
- **Multi-Status Support:** Mendukung status `success` (hijau centang), `info` (biru), dan `error` (merah).
- **Interaksi Geser & Sentuh:** Pengguna dapat mengetuk atau menggeser notifikasi ke atas (*swipe up*) untuk menutupnya seketika.
- **Konsistensi Visual:** Mengamankan tombol tengah `+` pada navigasi bawah agar tetap berada di tempatnya saat menyimpan profil atau foto profil.

---

## 📲 Unduh Berkas APK (Direct Download)

Tautan langsung (*direct stream download*) otomatis mengunduh APK tanpa dialihkan ke halaman lain:

- 🚀 **[⬇️ Unduh SIMPanan v1.2.7 APK (Direct Download Otomatis)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.7.apk)**
- 🔗 **[Link Mirror GitHub Raw](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.2.7.apk)**

---

*Hak Cipta © 2026 SIMPanan — Catatan Keuangan Pribadi Offline & Aman.*
