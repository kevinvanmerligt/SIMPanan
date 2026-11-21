# 🚀 Release Notes Patch 1.4.2 — SIMPanan

**Version:** `1.4.2`  
**Release Date:** November 21, 2026  
**Status:** Official Stable Release (Cover Scaling & Rule-of-Thirds Grid Photo Cropper, Self-Transfer Validation Guard, and Financial Report Date Period Filter)  
**APK File:** [`patch/SIMPanan-v1.4.2.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.4.2.apk)

---

## 🎯 Release Summary

Patch **v1.4.2** delivers three major targeted fixes across profile management, savings transfers, and financial reporting:

1. **🖼️ Full-Screen Profile Photo Cropper with Rule-of-Thirds Grid:**
   - **Automatic Cover Scaling:** Photos now automatically scale to cover the circular crop area completely upon opening, eliminating unsightly black letterboxing and empty space for portrait, landscape, and square images.
   - **Rule-of-Thirds Guide (3x3 Grid):** Visual alignment grid overlaid above the crop area helps users compose their avatars accurately without baking guide lines into the exported image.
   - **Boundary Clamping:** Panning and zooming are bounded to guarantee the circle is always completely filled across all rotations (90° turns) and gestures.

2. **🔄 Inter-Savings Transfer Guard & Self-Transfer Prevention:**
   - **Filtered Destination Dropdown:** The "Ke Tabungan" dropdown automatically filters out the currently selected source pocket to prevent self-transfers.
   - **Dynamic Selection Reassignment:** Switching the source pocket immediately updates or resets the destination pocket to a valid alternate option.
   - **Business Logic & UI Validation:** Explicit checks reject transfer attempts where source equals destination with clear feedback ("Tabungan asal dan tujuan tidak boleh sama.").
   - **Single-Pocket Warning:** Disables transfer actions and displays guidance when fewer than two savings pockets exist.
   - "Pindahkan Semua" functionality preserved.

3. **📅 Financial Report Period Filter (Laporan Keuangan):**
   - **Quick Period Filter Chips:** Quick selectors for "Bulan Ini", "Bulan Lalu", "7 Hari Terakhir", "30 Hari Terakhir", "Semua", and custom date range picker ("Pilih Tanggal").
   - **Active Date Range Label:** Prominent range indicator displaying formatted dates (e.g., "1 Nov 2026 - 21 Nov 2026") or "Semua Periode".
   - **Dynamic Report Data:** Total expense, category distribution, progress bar percentages, and outward flow badge calculate dynamically based on the chosen period.
   - **Clean Empty State:** Displays a neat informational message ("Belum ada pengeluaran pada periode ini") when no transactions exist in the selected timeframe.
   - Defaults to "Bulan Ini" on initial view.

4. **📦 Compressed Lightweight APK (~20–22 MB):**
   - Compiled for native Android arm64-v8a architecture with ProGuard code obfuscation and resource shrinking.

---

## 📲 Direct APK Download

- 🚀 **[⬇️ Download SIMPanan v1.4.2 APK (Automatic Direct Download)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.4.2.apk)**
- 🔗 **[GitHub Raw Mirror Link](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.4.2.apk)**

---

*Copyright © 2026 SIMPanan — Personal Finance Management.*
