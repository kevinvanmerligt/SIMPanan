# 💰 SIMPanan — Offline & Secure Personal Finance Manager

<p align="center">
  <img src="assets/images/logo.png" alt="SIMPanan Logo" width="120" style="border-radius: 24px; box-shadow: 0 4px 16px rgba(0,0,0,0.15);" />
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.47.7-blue.svg?logo=flutter" alt="Flutter" /></a>
  <a href="https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.2.apk" download="SIMPanan-v1.2.2.apk"><img src="https://img.shields.io/badge/Platform-Android%20APK-green.svg?logo=android" alt="Platform" /></a>
  <a href="./patch/patch-1.2.2.md"><img src="https://img.shields.io/badge/Patch-v1.2.2-emerald.svg" alt="Patch Version" /></a>
  <a href="#dynamic-theme-engine-system-light--dark"><img src="https://img.shields.io/badge/Theme-Light%20%7C%20Dark%20%7C%20System-teal.svg" alt="Theme Support" /></a>
  <a href="#high-refresh-rate-display-support-60--144hz"><img src="https://img.shields.io/badge/Display-60--144Hz%20Smooth-9cf.svg" alt="High Refresh Rate" /></a>
  <a href="#apk-size-compression--optimization"><img src="https://img.shields.io/badge/APK%20Size-~24%20MB%20(Compressed)-success.svg" alt="APK Size" /></a>
  <a href="https://sqlite.org"><img src="https://img.shields.io/badge/Database-SQLite%20Offline-blueviolet.svg?logo=sqlite" alt="Database" /></a>
  <a href="#100-offline-privacy--security"><img src="https://img.shields.io/badge/Security-Android%20Keystore%20Encrypted-success.svg" alt="Security" /></a>
</p>

**SIMPanan** is a daily personal finance tracker engineered with a modern, interactive interface, **butter-smooth animations (60–144Hz)**, an **adaptive theme engine (System / Light / Dark modes)** with tailored green palettes, and complete **100% offline local privacy**. All your expense and income records remain strictly on your personal device without requiring an internet connection or third-party accounts.

---

## 📥 Download APK (Instant Direct Download)

Download and install the official **SIMPanan v1.2.2** APK directly onto your Android smartphone. The link below is optimized for direct stream downloading: **clicking the link begins downloading the APK immediately to your phone or computer without page redirects**.

<p align="center">
  <a href="https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.2.apk" download="SIMPanan-v1.2.2.apk">
    <img src="https://img.shields.io/badge/⬇️%20DOWNLOAD%20APK%20v1.2.2-INSTANT%20DIRECT%20DOWNLOAD-059669?style=for-the-badge&logo=android&logoColor=white" alt="Download SIMPanan APK Directly" />
  </a>
</p>

### 🔗 Direct Download Links:
- 🚀 **[⬇️ Download SIMPanan v1.2.2 APK (Automatic Direct Download)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.2.apk)**
- 🔗 **[GitHub Raw Mirror Download Link](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.2.2.apk)**

> **Release File Metadata:**
> - **Filename:** `SIMPanan-v1.2.2.apk`
> - **Patch Version:** `1.2.2`
> - **Category:** Personal Finance Management / Expense Tracker
> - **Target OS:** Android 6.0+ (Marshmallow and above)
> - **Compressed Size:** ~20–25 MB (Optimized via R8 Code Minification & Resource Shrinking)
> - **Repository Path:** [`patch/SIMPanan-v1.2.2.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.2.apk)

### 📲 How to Install the APK on Android:
1. Tap the green **[Download APK v1.2.2]** button above. The APK file will download directly to your device.
2. Once the download completes, open the APK file via the notification drawer or your device's **Files / File Manager** app.
3. If an *"Install unknown apps"* prompt appears, enable permission for your browser or file manager.
4. Tap **Install**, then open and enjoy **SIMPanan**!

---

## 📦 Current Release Highlights: `Patch 1.2.2`

> 📄 Comprehensive release notes and changelog are documented in: **[`patch/patch-1.2.2.md`](./patch/patch-1.2.2.md)**

### ✨ What's New in Patch 1.2.2:
- 🌓 **Dynamic Theme Engine (System, Light, Dark):**
  - **System Default:** Automatically aligns with your device's global dark/light mode preference in real-time.
  - **Light Mode:** Crisp, clean light layout with elevated card surfaces.
  - **Dark Mode:** Deep, elegant dark obsidian surfaces that minimize eye strain in low-light environments.
  - Persisted locally via `SharedPreferences`.
- 🌿 **Tailored Dual Green Palette:**
  - **Light Theme:** Primary green is tuned **deeper and darker** (`#094A29`), delivering high contrast and sophisticated legibility on bright backgrounds.
  - **Dark Theme:** Primary green transforms into **luminous, vibrant mint emerald** (`#2BD980`) that pops clearly with night-friendly radiance.
- ⚡ **Massive APK Compression (Reduced from ~53 MB down to ~20–25 MB):**
  - Enabled R8 code minification and resource shrinking in Gradle release builds.
  - Stripped redundant x86/x86_64 PC emulator engine binaries, keeping only pure ARM libraries (`arm64-v8a` & `armeabi-v7a`) needed by 100% of physical Android smartphones.
  - Over 50% storage savings without losing any features.
- 🔢 **Clean Semantic Versioning:** Standardized on `v1.2.2` across documentation and release assets without messy build numbers.
- 🔘 **Smooth Segmented Sliding Pill:** Proportional transaction tabs (*All*, *Income*, *Expense*) featuring a smooth sliding indicator (`Curves.easeOutCubic`, 260ms) without sudden layout jumps.
- ✂️ **Zero-Lag Native Profile Photo Cropper:** Interactive positioning, pinch-to-zoom (1x – 4.5x), and 90° rotation directly within Flutter's render tree at 60/90/120/144Hz.
- ⚡ **High Refresh Rate Support:** Smooth scrolling and micro-interactions optimized for 60Hz, 90Hz, 120Hz, and 144Hz displays.

---

## 📌 Version History & Patch Index

| Patch Version | Release Date | APK File | Key Highlights | Release Notes |
| :---: | :---: | :---: | :--- | :---: |
| **`v1.2.2`** *(Latest)* | October 26, 2026 | [⬇️ `SIMPanan-v1.2.2.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.2.2.apk) | Dynamic theme engine (System/Light/Dark), dual adaptive green palette, massive APK compression to ~20-25 MB | [Read Patch 1.2.2 Notes](./patch/patch-1.2.2.md) |
| **`v1.1.11`** *(Previous)* | October 25, 2026 | *Superseded by v1.2.2* | Segmented transaction tabs with sliding pill animation, zero-lag native profile photo cropper (60-144Hz) | [Read Patch 1.1.11 Notes](./patch/patch-1.1.11.md) |
| **`v1.0.8`** *(Archived)* | October 25, 2026 | *Superseded by v1.2.2* | 60/90/120/144Hz high refresh rate, smooth page transitions, profile photo upload, 7-day expense chart | [Read Patch 1.0.8 Notes](./patch/patch-1.0.8.md) |
| **`v1.0.3`** *(Archived)* | October 25, 2026 | *Superseded by v1.2.2* | Cosmic vector logo, direct APK download, unified navigation headers across all tabs | [Read Patch 1.0.3 Notes](./patch/patch-1.0.3.md) |
| **`v1.0.0`** *(Initial Release)* | October 25, 2026 | *Superseded by v1.2.2* | Initial release: Realtime daily balance hero card, user profile, centered action dock, tab navigation | [Read Patch 1.0.0 Notes](./patch/patch-1.0.0.md) |

---

## ✨ Core Features

1. **📊 Realtime Daily Balance Hero Card**
   - Automatically computes remaining daily balance (**Income - Expenses**).
   - Instant overview of today's total income, total expenses, and transaction tally.
   - Formatted local calendar dates and day indicators.

2. **⚡ Quick Transaction Logging (Income & Expense)**
   - Instant modal sheet with iconic categories (*Food & Beverage, Shopping, Transport, Bills, Salary, Sales, etc.*).
   - Fast, responsive in-app numeric keypad; saves to local database in seconds.

3. **🌓 Adaptive Themes & Color System**
   - System auto-switching, permanent Light mode, or permanent Dark mode.
   - Specially calibrated green palette: darker and deeper in light mode for sharp readability, brighter and vibrant in dark mode for soft glowing clarity.

4. **📈 7-Day Expense Bar Chart**
   - Smooth animated bar chart powered by FlChart with horizontal grid lines.
   - Daily breakdown identifying trends, highest spending days, and a prominent "Today" highlight.

5. **📸 Profile & Interactive Photo Cropping (Zero Lag)**
   - Capture or select avatar photos from Camera or Gallery.
   - Built-in interactive cropper with rotation and smooth gestures running fluidly up to 144Hz.
   - Customizable name, age, and occupation tags.

6. **🔍 Flexible History & Search**
   - Filter transactions (*All*, *Income*, *Expense*) with proportional sliding pill tabs.
   - Realtime instant search by transaction title or category.
   - Swipe-to-delete action with confirmation.

7. **🥧 Category Spending Breakdown**
   - Aggregated total spending with category breakdown.
   - Visual percentage progress indicators for budgeting insights.

8. **🔒 100% Offline Privacy & Security**
   - Device-local SQLite database (`simpanan.db`).
   - Secure preferences stored with Android Keystore encryption.
   - Zero telemetry, no third-party analytics, no tracking, and no advertisements.

---

## 🗂️ Project Directory Structure

```text
c:\SIMPanan\
├── android\                    # Android native configuration, Proguard rules, Gradle setup
├── assets\
│   └── images\
│       └── logo.png            # Official SIMPanan logo asset
├── lib\
│   ├── core\                   # Theme engine, AppColors (dual palette), Rupiah & date utils
│   │   ├── constants\          # app_colors.dart (light/dark schemes), app_strings.dart
│   │   ├── database\           # SQLite local database helper & initial seed data
│   │   ├── theme\              # app_theme.dart (Material3 lightTheme & darkTheme)
│   │   ├── utils\              # currency_format.dart, date_format_id.dart
│   │   └── widgets\
│   │       ├── app_header.dart         # Global app header across navigation tabs
│   │       └── fade_slide_entrance.dart # Ultra-smooth entry animations (60-144Hz)
│   ├── data\                   # Transaction models, category data, & profile repository
│   ├── features\
│   │   ├── beranda\            # Home tab with Hero Card, Quick Actions, 7-Day Chart
│   │   │   └── widgets\
│   │   │       └── transaksi_hari_ini_list.dart # Sliding pill segmented control
│   │   ├── catat_transaksi\    # Modal sheet for instant income & expense recording
│   │   ├── laporan\            # Category expense reports & progress bars
│   │   ├── navigation\         # Bottom navigation bar with animated PageView
│   │   ├── profil\             # Profile info, Theme Mode switcher, & Photo Crop screen
│   │   │   └── screens\
│   │   │       └── photo_crop_screen.dart # Interactive native photo cropper
│   │   └── riwayat\            # Transaction history & instant search
│   ├── providers\              # FinanceProvider & ThemeProvider (SharedPreferences)
│   ├── app.dart                # MultiProvider & MaterialApp themeMode wiring
│   └── main.dart               # High refresh rate initialization (60/90/120/144Hz)
├── patch\                      # Patch releases & APK distribution folder
│   ├── README.md               # Index of all release patches
│   ├── patch-1.2.2.md          # Patch 1.2.2 detailed release notes
│   ├── patch-1.1.11.md         # Patch 1.1.11 release notes
│   ├── patch-1.0.8.md          # Patch 1.0.8 release notes
│   ├── patch-1.0.3.md          # Patch 1.0.3 release notes
│   ├── patch-1.0.0.md          # Patch 1.0.0 initial release archive
│   └── SIMPanan-v1.2.2.apk     # Compressed release APK (~20-25 MB, direct download ready)
├── pubspec.yaml
└── README.md                   # Main project documentation
```

---

## 🔒 Private Repository & Project Access

> [!IMPORTANT]
> **NOTICE:** This project and source code repository is **private and exclusive to the owner/author (*Author Only*)**.
> 
> General cloning, redistribution, or execution of the source code on other machines is not supported or authorized for the public. Public users may only download and run the official compiled APK on their Android devices via the direct download link provided above.

---

## 📄 License
Copyright © 2026 SIMPanan. Designed for simple, elegant, and secure offline personal financial management.
