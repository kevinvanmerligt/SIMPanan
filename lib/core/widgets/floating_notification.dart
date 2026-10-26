import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum FloatingNotificationType { success, info, warning, error }

/// Komponen notifikasi mengambang (Floating Toast) premium dan halus.
/// Menggunakan Overlay sehingga TIDAK mengganggu FloatingActionButton / tombol '+'
/// pada Scaffold (mencegah bug tombol plus terangkat ke atas).
class FloatingNotification {
  static OverlayEntry? _currentEntry;
  static Timer? _dismissTimer;

  /// Menampilkan notifikasi mengambang sukses
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(milliseconds: 2800),
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Berhasil',
      type: FloatingNotificationType.success,
      duration: duration,
    );
  }

  /// Menampilkan notifikasi mengambang info
  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(milliseconds: 2800),
  }) {
    show(
      context,
      message: message,
      title: title,
      type: FloatingNotificationType.info,
      duration: duration,
    );
  }

  /// Menampilkan notifikasi mengambang error
  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(milliseconds: 3200),
  }) {
    show(
      context,
      message: message,
      title: title ?? 'Perhatian',
      type: FloatingNotificationType.error,
      duration: duration,
    );
  }

  /// Menampilkan notifikasi mengambang kustom
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    FloatingNotificationType type = FloatingNotificationType.success,
    Duration duration = const Duration(milliseconds: 2800),
  }) {
    // Batalkan notifikasi sebelumnya jika masih aktif
    _dismissTimer?.cancel();
    _currentEntry?.remove();
    _currentEntry = null;

    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    late final OverlayEntry entry;
    final GlobalKey<_FloatingNotificationWidgetState> widgetKey =
        GlobalKey<_FloatingNotificationWidgetState>();

    entry = OverlayEntry(
      builder: (ctx) => _FloatingNotificationWidget(
        key: widgetKey,
        message: message,
        title: title,
        type: type,
        onDismiss: () {
          _dismissTimer?.cancel();
          if (_currentEntry == entry) {
            entry.remove();
            _currentEntry = null;
          }
        },
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);

    _dismissTimer = Timer(duration, () {
      widgetKey.currentState?.dismiss();
    });
  }
}

class _FloatingNotificationWidget extends StatefulWidget {
  final String message;
  final String? title;
  final FloatingNotificationType type;
  final VoidCallback onDismiss;

  const _FloatingNotificationWidget({
    super.key,
    required this.message,
    this.title,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<_FloatingNotificationWidget> createState() =>
      _FloatingNotificationWidgetState();
}

class _FloatingNotificationWidgetState
    extends State<_FloatingNotificationWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
      reverseDuration: const Duration(milliseconds: 240),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.6),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.92,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInCubic,
    ));

    _animController.forward();
  }

  void dismiss() {
    if (_isDismissing || !mounted) return;
    _isDismissing = true;
    _animController.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final topPadding = MediaQuery.of(context).padding.top;

    Color accentColor;
    IconData iconData;

    switch (widget.type) {
      case FloatingNotificationType.success:
        accentColor = colors.primaryGreen;
        iconData = Icons.check_circle_rounded;
        break;
      case FloatingNotificationType.info:
        accentColor = Colors.blue.shade400;
        iconData = Icons.info_rounded;
        break;
      case FloatingNotificationType.warning:
        accentColor = Colors.amber.shade700;
        iconData = Icons.warning_rounded;
        break;
      case FloatingNotificationType.error:
        accentColor = Colors.red.shade400;
        iconData = Icons.error_rounded;
        break;
    }

    return Positioned(
      top: topPadding + 14,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: dismiss,
                onVerticalDragUpdate: (details) {
                  if (details.primaryDelta != null && details.primaryDelta! < -4) {
                    dismiss();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: colors.isDark
                        ? const Color(0xFF1B231D).withValues(alpha: 0.96)
                        : Colors.white.withValues(alpha: 0.98),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: accentColor.withValues(alpha: colors.isDark ? 0.35 : 0.25),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: colors.isDark ? 0.45 : 0.12),
                        blurRadius: 16,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.14),
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Badge Ikon Mengambang
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          iconData,
                          color: accentColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Teks Notifikasi
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.title != null) ...[
                              Text(
                                widget.title!,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: colors.textPrimary,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 2),
                            ],
                            Text(
                              widget.message,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: widget.title != null
                                    ? FontWeight.w500
                                    : FontWeight.w600,
                                color: widget.title != null
                                    ? colors.textSecondary
                                    : colors.textPrimary,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Ikon Tutup Cepat
                      GestureDetector(
                        onTap: dismiss,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: colors.cardBorder.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            size: 14,
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
