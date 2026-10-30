import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../navigation/main_nav_screen.dart';

/// Layar animasi pembuka (Splash Entrance Screen) yang halus, ceria, dan lucu.
/// Menampilkan maskot celengan & koin kawaii yang berkedip dan memantul ceria,
/// partikel bintang/koin yang melayang meriah, serta progress bar koin bergulir.
class SplashScreen extends StatefulWidget {
  final bool isPreviewOnly;

  const SplashScreen({super.key, this.isPreviewOnly = false});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Controller untuk entrance & jiggle maskot
  late final AnimationController _mascotController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _bounceAnimation;

  // Controller untuk kedipan mata maskot
  late final AnimationController _blinkController;

  // Controller untuk koin jatuh ke dalam celengan
  late final AnimationController _coinDropController;
  late final Animation<double> _coinYAnimation;
  late final Animation<double> _coinScaleAnimation;
  late final Animation<double> _coinRotateAnimation;

  // Controller untuk partikel & aura berdenyut
  late final AnimationController _particleController;

  // Controller untuk progress bar
  late final AnimationController _progressController;

  // Status teks lucu
  String _statusMessage = 'Menghitung koin receh... 🪙';
  Timer? _statusTimer1;
  Timer? _statusTimer2;
  Timer? _statusTimer3;
  Timer? _navTimer;
  Timer? _blinkTimer;
  Timer? _coinDropTimer;

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // 1. Maskot Entrance & Jiggle
    _mascotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _mascotController,
      curve: Curves.elasticOut,
    );

    _bounceAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(
        parent: _mascotController,
        curve: Curves.easeInOutSine,
      ),
    );

    _mascotController.forward().then((_) {
      if (mounted) {
        _mascotController.repeat(reverse: true, period: const Duration(milliseconds: 1400));
      }
    });

    // 2. Kedipan mata maskot (berkedip setiap ~2 detik)
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _startBlinkLoop();

    // 3. Koin jatuh masuk ke celengan dengan pantulan lucu
    _coinDropController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _coinYAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: -100.0, end: 18.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 65,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 18.0, end: 24.0)
            .chain(CurveTween(curve: Curves.easeInQuad)),
        weight: 35,
      ),
    ]).animate(_coinDropController);

    _coinScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.2, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInBack)),
        weight: 35,
      ),
    ]).animate(_coinDropController);

    _coinRotateAnimation = Tween<double>(begin: -0.6, end: 0.0).animate(
      CurvedAnimation(
        parent: _coinDropController,
        curve: Curves.easeOutBack,
      ),
    );

    _coinDropTimer = Timer(const Duration(milliseconds: 350), () {
      if (mounted) _coinDropController.forward();
    });

    // 4. Partikel melayang berkesinambungan (60-144Hz)
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // 5. Progress Bar dari 0.0 sampai 1.0 dalam 2.4 detik
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    _progressController.forward();

    // Timers untuk mengubah pesan status lucu
    _statusTimer1 = Timer(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() => _statusMessage = 'Merapikan dompet harian... 👛');
      }
    });

    _statusTimer2 = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _statusMessage = 'Menyiapkan catatan keuanganmu... ✨');
      }
    });

    _statusTimer3 = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) {
        setState(() => _statusMessage = 'Siap! Selamat datang di SIMPanan! 🎉');
      }
    });

    // Otomatis pindah ke layar utama setelah animasi selesai
    if (!widget.isPreviewOnly) {
      _navTimer = Timer(const Duration(milliseconds: 2750), _navigateToHome);
    }
  }

  void _startBlinkLoop() {
    _scheduleNextBlink();
  }

  void _scheduleNextBlink() {
    _blinkTimer?.cancel();
    _blinkTimer = Timer(const Duration(milliseconds: 1800), () async {
      if (!mounted) return;
      try {
        await _blinkController.forward();
        if (mounted) {
          await _blinkController.reverse();
        }
      } catch (_) {}
      if (mounted) {
        _scheduleNextBlink();
      }
    });
  }

  void _navigateToHome() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    if (widget.isPreviewOnly) {
      Navigator.pop(context);
      return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainNavScreen(),
        transitionDuration: const Duration(milliseconds: 550),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.96, end: 1.0).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _statusTimer1?.cancel();
    _statusTimer2?.cancel();
    _statusTimer3?.cancel();
    _navTimer?.cancel();
    _coinDropTimer?.cancel();
    _blinkTimer?.cancel();
    _mascotController.dispose();
    _blinkController.dispose();
    _coinDropController.dispose();
    _particleController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colors.background,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _navigateToHome,
        child: Stack(
          children: [
            // 1. Latar Belakang Gradasi Halus
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.2),
                    radius: 1.1,
                    colors: [
                      colors.primaryGreen.withValues(alpha: colors.isDark ? 0.22 : 0.12),
                      colors.background,
                    ],
                  ),
                ),
              ),
            ),

            // 2. Partikel Bintang & Koin Mengambang Meriah
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _FestiveSparklePainter(
                      progress: _particleController.value,
                      isDark: colors.isDark,
                      primaryColor: colors.primaryGreen,
                    ),
                  );
                },
              ),
            ),

            // 3. Tombol Lewati di Pojok Kanan Atas
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 16),
                  child: InkWell(
                    onTap: _navigateToHome,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: colors.cardSurface.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colors.cardBorder.withValues(alpha: 0.6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.isPreviewOnly ? 'Tutup' : 'Lewati',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 11,
                            color: colors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 4. Konten Utama: Maskot Kawaii, Logo, & Judul
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Area Maskot Kawaii + Koin Berpantul
                      SizedBox(
                        width: 240,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Aura Cahaya Berdenyut di Belakang Maskot
                            AnimatedBuilder(
                              animation: _mascotController,
                              builder: (context, _) {
                                final pulse = (_mascotController.value * 0.15) + 0.85;
                                return Container(
                                  width: 170 * pulse,
                                  height: 170 * pulse,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        colors.primaryGreen.withValues(
                                          alpha: colors.isDark ? 0.35 : 0.20,
                                        ),
                                        colors.primaryGreen.withValues(alpha: 0.0),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Koin Emas yang Melompat Masuk ke Celengan
                            AnimatedBuilder(
                              animation: _coinDropController,
                              builder: (context, _) {
                                return Transform.translate(
                                  offset: Offset(0, _coinYAnimation.value),
                                  child: Transform.rotate(
                                    angle: _coinRotateAnimation.value,
                                    child: Transform.scale(
                                      scale: _coinScaleAnimation.value,
                                      child: _buildKawaiiCoin(),
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Karakter Celengan / Dompet Kawaii Lucu
                            AnimatedBuilder(
                              animation: _mascotController,
                              builder: (context, _) {
                                return Transform.translate(
                                  offset: Offset(0, _bounceAnimation.value),
                                  child: ScaleTransition(
                                    scale: _scaleAnimation,
                                    child: _buildKawaiiPiggyMascot(colors),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Logo SIMPanan & Nama Aplikasi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: colors.primaryGreen.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, error, stackTrace) => Container(
                                  color: colors.primaryGreen,
                                  child: const Icon(Icons.savings, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SIMPanan',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: colors.textPrimary,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                'Kelola Duit Jadi Lucu & Aman 🍃',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: colors.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Progress Bar Menggelinding dengan Koin Kecil
                      SizedBox(
                        width: size.width * 0.72,
                        child: Column(
                          children: [
                            AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, _) {
                                final p = _progressController.value;
                                return Column(
                                  children: [
                                    // Ikon Koin Mini yang Berlari di atas Progress Bar
                                    Align(
                                      alignment: Alignment(-1.0 + (p * 2.0), 0),
                                      child: Transform.rotate(
                                        angle: p * math.pi * 4,
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          margin: const EdgeInsets.only(bottom: 4),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: const Color(0xFFFFD700),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFFFFB300)
                                                    .withValues(alpha: 0.5),
                                                blurRadius: 6,
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '🪙',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Track Progress Bar
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 8,
                                        color: colors.cardBorder.withValues(alpha: 0.4),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: FractionallySizedBox(
                                            widthFactor: p.clamp(0.02, 1.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    colors.primaryGreen,
                                                    colors.isDark
                                                        ? const Color(0xFF6EE7B7)
                                                        : const Color(0xFF10B981),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 14),
                            // Pesan Status Dinamis
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, anim) => FadeTransition(
                                opacity: anim,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.2),
                                    end: Offset.zero,
                                  ).animate(anim),
                                  child: child,
                                ),
                              ),
                              child: Text(
                                _statusMessage,
                                key: ValueKey<String>(_statusMessage),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 5. Badge Versi di Bawah
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: colors.primaryPillBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      'SIMPanan v1.2.10 • 100% Offline & Aman',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colors.primaryGreen,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Koin Emas Kawaii yang memantul masuk
  Widget _buildKawaiiCoin() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.3, -0.3),
          radius: 0.9,
          colors: [
            Color(0xFFFFF59D), // Kuning emas cerah
            Color(0xFFFFD54F),
            Color(0xFFFFA000), // Emas tua
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFB300).withValues(alpha: 0.6),
            blurRadius: 14,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(color: const Color(0xFFFFF9C4), width: 2),
      ),
      child: const Center(
        child: Text(
          'Rp',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Color(0xFF5D4037),
          ),
        ),
      ),
    );
  }

  /// Maskot Kawaii Celengan Lucu dengan wajah manis & mata berkedip
  Widget _buildKawaiiPiggyMascot(AppColorScheme colors) {
    return SizedBox(
      width: 140,
      height: 125,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Telinga Kiri
          Positioned(
            left: 14,
            top: 6,
            child: Transform.rotate(
              angle: -0.35,
              child: _buildEar(colors),
            ),
          ),
          // Telinga Kanan
          Positioned(
            right: 14,
            top: 6,
            child: Transform.rotate(
              angle: 0.35,
              child: _buildEar(colors),
            ),
          ),

          // Badan Utama Celengan (Chubby & Bulat Gemas)
          Positioned(
            bottom: 0,
            child: Container(
              width: 126,
              height: 104,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors.isDark
                      ? [
                          const Color(0xFF34D399), // Mint cerah
                          const Color(0xFF059669), // Emerald
                          const Color(0xFF065F46), // Hijau tua malam
                        ]
                      : [
                          const Color(0xFF6EE7B7), // Mint lembut
                          const Color(0xFF10B981), // Emerald cerah
                          const Color(0xFF047857), // Forest green
                        ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.primaryGreen.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Lubang Celengan di Atas
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: 32,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  // Wajah Kawaii: Mata, Pipi Merona, Hidung/Moncong
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Baris Mata & Pipi Merona
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Pipi Kiri Pink Merona
                              _buildRosyCheek(),
                              const SizedBox(width: 4),
                              // Mata Kiri
                              _buildEye(),
                              const SizedBox(width: 22),
                              // Mata Kanan
                              _buildEye(),
                              const SizedBox(width: 4),
                              // Pipi Kanan Pink Merona
                              _buildRosyCheek(),
                            ],
                          ),
                          const SizedBox(height: 6),
                          // Hidung / Moncong Celengan Lucu
                          Container(
                            width: 34,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.28),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildNostril(),
                                const SizedBox(width: 6),
                                _buildNostril(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEar(AppColorScheme colors) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: colors.isDark ? const Color(0xFF10B981) : const Color(0xFF34D399),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Center(
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: const Color(0xFFFF80AB).withValues(alpha: 0.75), // Pink telinga
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildEye() {
    return AnimatedBuilder(
      animation: _blinkController,
      builder: (context, _) {
        final isBlinking = _blinkController.value > 0.4;
        if (isBlinking) {
          // Mata tersenyum saat berkedip (^)
          return Container(
            width: 14,
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }
        // Mata bulat kawaii dengan binar kilau putih
        return Container(
          width: 14,
          height: 14,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF0F172A),
          ),
          child: Align(
            alignment: const Alignment(-0.4, -0.4),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRosyCheek() {
    return Container(
      width: 10,
      height: 6,
      decoration: BoxDecoration(
        color: const Color(0xFFFF4081).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildNostril() {
    return Container(
      width: 5,
      height: 7,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

/// CustomPainter untuk partikel bintang dan koin yang melayang meriah
class _FestiveSparklePainter extends CustomPainter {
  final double progress;
  final bool isDark;
  final Color primaryColor;

  _FestiveSparklePainter({
    required this.progress,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rand = math.Random(42); // Seed konstan agar posisi partikel stabil

    final paintStar = Paint()
      ..color = (isDark ? const Color(0xFFFDE68A) : const Color(0xFFF59E0B))
          .withValues(alpha: isDark ? 0.65 : 0.45)
      ..style = PaintingStyle.fill;

    final paintMint = Paint()
      ..color = primaryColor.withValues(alpha: isDark ? 0.45 : 0.25)
      ..style = PaintingStyle.fill;

    // Gambar 26 partikel bintang dan kilau di layar
    for (int i = 0; i < 26; i++) {
      final baseX = rand.nextDouble() * size.width;
      final startY = rand.nextDouble() * size.height;
      final speed = 0.4 + rand.nextDouble() * 0.8;
      final starSize = 2.5 + rand.nextDouble() * 5.0;

      // Animasi melayang ke atas dengan offset sinus
      final currentY = (startY - (progress * size.height * speed)) % size.height;
      final wobbleX = math.sin((progress * math.pi * 2) + i) * 14.0;
      final posX = (baseX + wobbleX) % size.width;

      if (i % 3 == 0) {
        // Gambarkan bintang berkilau 4 sudut (✨)
        _draw4PointStar(canvas, Offset(posX, currentY), starSize, paintStar);
      } else if (i % 3 == 1) {
        // Gambarkan lingkaran kilau mint
        canvas.drawCircle(Offset(posX, currentY), starSize * 0.8, paintMint);
      } else {
        // Gambarkan koin mikro emas mini
        final coinPaint = Paint()
          ..color = const Color(0xFFFFD54F).withValues(alpha: 0.5)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(posX, currentY), starSize * 0.9, coinPaint);
      }
    }
  }

  void _draw4PointStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    final inner = radius * 0.28;

    path.moveTo(center.dx, center.dy - radius);
    path.lineTo(center.dx + inner, center.dy - inner);
    path.lineTo(center.dx + radius, center.dy);
    path.lineTo(center.dx + inner, center.dy + inner);
    path.lineTo(center.dx, center.dy + radius);
    path.lineTo(center.dx - inner, center.dy + inner);
    path.lineTo(center.dx - radius, center.dy);
    path.lineTo(center.dx - inner, center.dy - inner);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _FestiveSparklePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
