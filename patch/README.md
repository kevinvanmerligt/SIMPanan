# 📁 Folder Patch & Release Notes — SIMPanan

Folder ini berisi riwayat pembaruan (*patch notes*), changelog resmi, dan berkas rilis binary (APK) dari aplikasi **SIMPanan**. Setiap kali ada rilis atau pembaruan baru yang diunggah ke GitHub, dokumentasi patch dan arsip versinya disimpan di folder ini.

---

## 📌 Daftar Patch yang Tersedia

| Versi Patch | Tanggal Rilis | File APK | Ringkasan Utama | Dokumen Lengkap |
| :---: | :---: | :---: | :--- | :---: |
| **`v1.2.2`** *(Terbaru)* | 26 Oktober 2026 | [⬇️ `SIMPanan-v1.2.2.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.2.apk) | Pengaturan tema dinamis (Sistem/Terang/Gelap), palet hijau adaptif (lebih terang di dark mode, lebih gelap di light mode), kompresi APK ~20-25 MB | [Baca Patch Notes](./patch-1.2.2.md) |
| **`v1.1.11`** *(Sebelumnya)* | 25 Oktober 2026 | *Telah diperbarui ke v1.2.2* | Segmented control tab transaksi animasi sliding pill tanpa jerking scroll, crop foto profil native tanpa lag 60-144Hz | [Baca Patch Notes](./patch-1.1.11.md) |
| **`v1.0.8`** *(Arsip)* | 25 Oktober 2026 | *Telah digantikan ke v1.2.2* | Dukungan 60/90/120/144Hz high refresh rate, transisi halaman halus, animasi navigasi, upload foto profil, grafik 7 hari | [Baca Patch Notes](./patch-1.0.8.md) |
| **`v1.0.3`** *(Arsip)* | 25 Oktober 2026 | *Telah digantikan ke v1.2.2* | Logo anime kosmik baru, direct APK download tanpa pindah halaman, hapus patokan saldo & keamanan profil, header di semua tabs | [Baca Patch Notes](./patch-1.0.3.md) |
| **`v1.0.0`** *(Rilis Perdana)* | 25 Oktober 2026 | *Telah digantikan ke v1.2.2* | Rilis perdana: Saldo harian, profil pengguna, tombol center docking, navigasi tabs | [Baca Patch Notes](./patch-1.0.0.md) |

---

## 🛠️ Standar Pembuatan Patch Baru
Untuk pembaruan versi selanjutnya saat mengunggah ke GitHub:
1. Buat file `patch-X.Y.Z.md` di dalam folder `patch/`.
2. Jelaskan fitur baru, perbaikan bug, atau perubahan pada versi tersebut.
3. Salin hasil build APK terbaru dengan format nama `SIMPanan-vX.Y.Z.apk`.
4. Tambahkan baris baru pada tabel di atas.
5. Perbarui bagian rilis pada [`README.md`](../README.md) utama proyek.
