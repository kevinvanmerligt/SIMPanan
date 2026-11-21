# 📁 Folder Patch & Release Notes — SIMPanan

Folder ini berisi riwayat pembaruan (*patch notes*), changelog resmi, dan berkas rilis binary (APK) dari aplikasi **SIMPanan**. Setiap kali ada rilis atau pembaruan baru yang diunggah ke GitHub, dokumentasi patch dan arsip versinya disimpan di folder ini.

---

## 📌 Daftar Patch yang Tersedia

| Versi Patch | Tanggal Rilis | File APK | Ringkasan Utama | Dokumen Lengkap |
| :---: | :---: | :---: | :--- | :---: |
| **`v1.4.2`** *(Terbaru)* | 21 November 2026 | [⬇️ `SIMPanan-v1.4.2.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.4.2.apk) | Pemilih foto profil cover & grid 3x3, proteksi transfer tabungan sendiri, filter periode Laporan Keuangan | [Baca Patch Notes](./patch-1.4.2.md) |
| **`v1.4.1.7`** *(Sebelumnya)* | 21 November 2026 | *Telah digantikan ke v1.4.2* | Token warna netral badge & border tabungan, gradien dinamis kartu hero saldo, kontras tinggi tooltip grafik batang | [Baca Patch Notes](./patch-1.4.1.7.md) |
| **`v1.4.1`** *(Sebelumnya)* | 21 November 2026 | *Telah digantikan ke v1.4.2* | Peningkatan kontras tema terang, penghapusan efek neon tema gelap, pembaruan warna merah & aksen elegan | [Baca Patch Notes](./patch-1.4.1.md) |
| **`v1.4.0`** *(Sebelumnya)* | 20 November 2026 | *Telah digantikan ke v1.4.1.7* | Akumulasi total saldo tabungan di Beranda, banner menonjol transfer antar tabungan, logo tabungan besar di laporan, penyelarasan warna aksen, pembersihan saldo hapus tabungan, opsi ikon titik tiga | [Baca Patch Notes](./patch-1.4.0.md) |
| **`v1.3.11`** *(Sebelumnya)* | 14 November 2026 | *Telah digantikan ke v1.4.1* | Pemilih tanggal lahir & hitung umur otomatis, penguncian pekerjaan < 18 tahun (Pelajar), placeholder nama pengguna, pemilih warna kustom HSL tabungan | [Baca Patch Notes](./patch-1.3.11.md) |
| **`v1.3.8`** *(Sebelumnya)* | 12 November 2026 | *Telah digantikan ke v1.4.1* | Laporan total pengeluaran teratas, kelola tabungan per baris, proteksi transfer anti-minus, pelacakan hutang & saldo minus | [Baca Patch Notes](./patch-1.3.8.md) |
| **`v1.3.1`** *(Sebelumnya)* | 9 November 2026 | *Telah digantikan ke v1.4.1* | Fitur Multi-Tabungan & Kantong Rencana, alokasi transaksi per tabungan, transfer saldo antar tabungan, animasi super smooth | [Baca Patch Notes](./patch-1.3.1.md) |
| **`v1.2.10`** *(Sebelumnya)* | 30 Oktober 2026 | *Telah digantikan ke v1.4.1* | Pembaruan ikon 3D 'S' emas glossy, perbaikan kontras checklist kategori, simplifikasi tombol "Simpan", pembersihan kode | [Baca Patch Notes](./patch-1.2.10.md) |
| **`v1.2.7`** *(Sebelumnya)* | 26 Oktober 2026 | *Telah digantikan ke v1.4.1* | Animasi pembuka/splash lucu & meriah (maskot kawaii, koin elastis, partikel bintang), notifikasi mengambang | [Baca Patch Notes](./patch-1.2.7.md) |
| **`v1.2.2`** *(Sebelumnya)* | 26 Oktober 2026 | *Telah digantikan ke v1.4.1* | Pengaturan tema dinamis (Sistem/Terang/Gelap), palet hijau adaptif (lebih terang di dark mode, lebih gelap di light mode) | [Baca Patch Notes](./patch-1.2.2.md) |
| **`v1.1.11`** *(Arsip)* | 25 Oktober 2026 | *Telah digantikan ke v1.4.1* | Segmented control tab transaksi animasi sliding pill tanpa jerking scroll, crop foto profil native tanpa lag 60-144Hz | [Baca Patch Notes](./patch-1.1.11.md) |
| **`v1.0.8`** *(Arsip)* | 25 Oktober 2026 | *Telah digantikan ke v1.4.1* | Dukungan 60/90/120/144Hz high refresh rate, transisi halaman halus, animasi navigasi, upload foto profil, grafik 7 hari | [Baca Patch Notes](./patch-1.0.8.md) |
| **`v1.0.3`** *(Arsip)* | 25 Oktober 2026 | *Telah digantikan ke v1.4.1* | Logo baru, direct APK download tanpa pindah halaman, header di semua tabs | [Baca Patch Notes](./patch-1.0.3.md) |
| **`v1.0.0`** *(Rilis Perdana)* | 25 Oktober 2026 | *Telah digantikan ke v1.4.1* | Rilis perdana: Saldo harian, profil pengguna, tombol center docking, navigasi tabs | [Baca Patch Notes](./patch-1.0.0.md) |

---

## 🛠️ Standar Pembuatan Patch Baru
Untuk pembaruan versi selanjutnya saat mengunggah ke GitHub:
1. Buat file `patch-X.Y.Z.md` di dalam folder `patch/`.
2. Jelaskan fitur baru, perbaikan bug, atau perubahan pada versi tersebut.
3. Salin hasil build APK terbaru dengan format nama `SIMPanan-vX.Y.Z.apk`.
4. Tambahkan baris baru pada tabel di atas.
5. Perbarui bagian rilis pada [`README.md`](../README.md) utama proyek.
