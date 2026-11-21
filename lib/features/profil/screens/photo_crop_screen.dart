import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/floating_notification.dart';

class PhotoCropScreen extends StatefulWidget {
  final File imageFile;

  const PhotoCropScreen({super.key, required this.imageFile});

  @override
  State<PhotoCropScreen> createState() => _PhotoCropScreenState();
}

class _PhotoCropScreenState extends State<PhotoCropScreen> {
  final GlobalKey _boundaryKey = GlobalKey();
  final TransformationController _transformController = TransformationController();
  int _rotationQuarterTurns = 0;
  bool _isProcessing = false;
  int? _imageWidth;
  int? _imageHeight;
  double? _lastCropSize;

  @override
  void initState() {
    super.initState();
    _loadImageDimensions();
  }

  Future<void> _loadImageDimensions() async {
    try {
      final bytes = await widget.imageFile.readAsBytes();
      final decoded = await decodeImageFromList(bytes);
      if (mounted) {
        setState(() {
          _imageWidth = decoded.width;
          _imageHeight = decoded.height;
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  void _calculateAndApplyTransform(double cropSize) {
    if (_imageWidth == null || _imageHeight == null) return;

    final isTurnsOdd = _rotationQuarterTurns % 2 == 1;
    final effectiveW = isTurnsOdd ? _imageHeight!.toDouble() : _imageWidth!.toDouble();
    final effectiveH = isTurnsOdd ? _imageWidth!.toDouble() : _imageHeight!.toDouble();

    final scale = math.max(cropSize / effectiveW, cropSize / effectiveH);
    final childW = effectiveW * scale;
    final childH = effectiveH * scale;

    final offsetX = -(childW - cropSize) / 2.0;
    final offsetY = -(childH - cropSize) / 2.0;

    _transformController.value = Matrix4.identity()..setTranslationRaw(offsetX, offsetY, 0.0);
  }

  void _rotate(double cropSize) {
    setState(() {
      _rotationQuarterTurns = (_rotationQuarterTurns + 1) % 4;
      _calculateAndApplyTransform(cropSize);
    });
  }

  void _reset(double cropSize) {
    setState(() {
      _calculateAndApplyTransform(cropSize);
    });
  }

  Future<void> _cropAndSave() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final boundary = _boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        throw Exception('Gagal membaca area crop');
      }

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Gagal mengekspor data gambar');
      }

      final buffer = byteData.buffer.asUint8List();
      final tempDir = await getApplicationDocumentsDirectory();
      final croppedFile = File(
        '${tempDir.path}/cropped_avatar_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await croppedFile.writeAsBytes(buffer);

      if (mounted) {
        Navigator.pop(context, croppedFile);
      }
    } catch (e) {
      if (mounted) {
        FloatingNotification.showError(
          context,
          title: 'Gagal Memotong Foto',
          message: '$e',
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cropSize = (screenSize.width * 0.85).clamp(260.0, 360.0);

    if (_lastCropSize != cropSize && _imageWidth != null) {
      _lastCropSize = cropSize;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _calculateAndApplyTransform(cropSize);
        }
      });
    }

    final isTurnsOdd = _rotationQuarterTurns % 2 == 1;
    final effectiveW = (_imageWidth != null && _imageHeight != null)
        ? (isTurnsOdd ? _imageHeight!.toDouble() : _imageWidth!.toDouble())
        : cropSize;
    final effectiveH = (_imageWidth != null && _imageHeight != null)
        ? (isTurnsOdd ? _imageWidth!.toDouble() : _imageHeight!.toDouble())
        : cropSize;

    final scale = math.max(cropSize / effectiveW, cropSize / effectiveH);
    final childW = effectiveW * scale;
    final childH = effectiveH * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1115),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Sesuaikan Foto Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _isProcessing
                ? const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryGreen),
                    ),
                  )
                : TextButton(
                    onPressed: _cropAndSave,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      'Gunakan',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Text(
            'Geser & cubit untuk memperbesar / memposisikan foto',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Center(
              child: SizedBox(
                width: cropSize,
                height: cropSize,
                child: Stack(
                  children: [
                    RepaintBoundary(
                      key: _boundaryKey,
                      child: ClipOval(
                        child: SizedBox(
                          width: cropSize,
                          height: cropSize,
                          child: _imageWidth == null
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryGreen,
                                  ),
                                )
                              : InteractiveViewer(
                                  transformationController: _transformController,
                                  minScale: 1.0,
                                  maxScale: 4.5,
                                  boundaryMargin: EdgeInsets.zero,
                                  clipBehavior: Clip.none,
                                  child: SizedBox(
                                    width: childW,
                                    height: childH,
                                    child: RotatedBox(
                                      quarterTurns: _rotationQuarterTurns,
                                      child: Image.file(
                                        widget.imageFile,
                                        width: isTurnsOdd ? childH : childW,
                                        height: isTurnsOdd ? childW : childH,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),

                    Positioned.fill(
                      child: IgnorePointer(
                        child: ClipOval(
                          child: CustomPaint(
                            painter: CropGridPainter(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF181B20),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.rotate_right_rounded,
                    label: 'Putar 90°',
                    onTap: () => _rotate(cropSize),
                  ),
                  _buildActionButton(
                    icon: Icons.refresh_rounded,
                    label: 'Reset',
                    onTap: () => _reset(cropSize),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CropGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;

    canvas.drawLine(Offset(w / 3, 0), Offset(w / 3, h), linePaint);
    canvas.drawLine(Offset(2 * w / 3, 0), Offset(2 * w / 3, h), linePaint);
    canvas.drawLine(Offset(0, h / 3), Offset(w, h / 3), linePaint);
    canvas.drawLine(Offset(0, 2 * h / 3), Offset(w, 2 * h / 3), linePaint);

    canvas.drawCircle(Offset(w / 2, h / 2), (w / 2) - 1, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
