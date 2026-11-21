# 🚀 Release Notes Patch 1.4.1.7 — SIMPanan

**Version:** `1.4.1.7`  
**Release Date:** November 21, 2026  
**Status:** Official Stable Release (Neutral Badge & Border Tokens, Dynamic Hero Balance Gradient, High-Contrast Chart Tooltip, and Theme Standardization)  
**APK File:** [`patch/SIMPanan-v1.4.1.7.apk`](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.4.1.7.apk)

---

## 🎯 Release Summary

Patch **v1.4.1.7** provides targeted visual and contrast refinements across light and dark modes, resolving UI color collisions, standardizing semantic status tokens, and enhancing data readability:

1. **🏷️ Neutral "Utama" Badge & Card Border Tokens:**
   - Decoupled the "Utama" tabungan indicator from financial status colors to avoid false positive signals on negative balances.
   - Introduced centralized neutral tokens (`badgeNeutralBg` and `badgeNeutralText`) utilizing soft indigo hues with contrast exceeding 7.5:1.
   - Standardized tabungan card borders to neutral tones (`colors.cardBorder`) across all states.

2. **📊 Dynamic Hero Balance Card Gradient:**
   - Implemented dynamic background theming based on net savings:
     - **Positive (> 0):** Deep emerald green financial theme.
     - **Zero (== 0):** Neutral slate tone (`#334155` Light / `#1E293B` Dark).
     - **Negative (< 0):** Dark rose/crimson gradient (`#9F1239` to `#BE123C` Light / `#881337` to `#9F1239` Dark).
   - High-contrast pure white primary typography and a dedicated contrast pill badge for negative deficits.

3. **📈 High-Contrast Bar Chart Tooltip:**
   - Added explicit dark tooltip styling (`#1F2937`) with crisp white typography (`#FFFFFF`) for date labels and currency amounts, ensuring legible values across both light and dark themes.

4. **📦 Compressed Lightweight APK (~20–22 MB):**
   - Built with native arm64-v8a optimization, resource shrinking, and ProGuard optimizations for high performance and low storage footprint.

---

## 📲 Direct APK Download

- 🚀 **[⬇️ Download SIMPanan v1.4.1.7 APK (Automatic Direct Download)](https://raw.githubusercontent.com/kevinvanmerligt/SIMPanan/main/patch/SIMPanan-v1.4.1.7.apk)**
- 🔗 **[GitHub Raw Mirror Link](https://github.com/kevinvanmerligt/SIMPanan/raw/main/patch/SIMPanan-v1.4.1.7.apk)**

---

*Copyright © 2026 SIMPanan — Personal Finance Management.*
