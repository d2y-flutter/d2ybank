import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_icon_size.dart';
import 'package:d2ybank/core/config/app_radius.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum D2YCameraCaptureMode { ktp, face }

class D2YCameraCapturePage extends StatefulWidget {
  final String title;
  final String instruction;
  final D2YCameraCaptureMode mode;
  final CameraLensDirection lensDirection;
  final ValueChanged<XFile> onCaptured;

  const D2YCameraCapturePage({
    super.key,
    required this.title,
    required this.instruction,
    required this.mode,
    required this.lensDirection,
    required this.onCaptured,
  });

  @override
  State<D2YCameraCapturePage> createState() => _D2YCameraCapturePageState();
}

class _D2YCameraCapturePageState extends State<D2YCameraCapturePage> {
  CameraController? _controller;
  bool _isInitializing = true;
  bool _isCapturing = false;
  bool _isFlashOn = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();

      final selectedCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == widget.lensDirection,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        selectedCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();

      if (!mounted) return;

      setState(() {
        _controller = controller;
        _isInitializing = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isInitializing = false;
        _errorMessage = 'Kamera tidak dapat dibuka. Periksa izin kamera.';
      });
    }
  }

  Future<void> _toggleFlash() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    final nextFlash = !_isFlashOn;
    await controller.setFlashMode(nextFlash ? FlashMode.torch : FlashMode.off);

    if (!mounted) return;
    setState(() => _isFlashOn = nextFlash);
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _isCapturing) {
      return;
    }

    try {
      setState(() => _isCapturing = true);

      final file = await controller.takePicture();

      if (!mounted) return;

      widget.onCaptured(file);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isCapturing = false;
        _errorMessage = 'Gagal mengambil foto. Silakan coba lagi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Scaffold(
      backgroundColor: AppColors.onBackground,
      body: SafeArea(
        child: Column(
          children: [
            _CameraTopBar(
              title: widget.title,
              onBack: () => context.pop(),
              onHelp: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(widget.instruction)),
                );
              },
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (_isInitializing)
                    const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.primaryFixedDim),
                      ),
                    )
                  else if (_errorMessage != null)
                    _CameraErrorView(
                      message: _errorMessage!,
                      onRetry: _initCamera,
                    )
                  else if (controller != null && controller.value.isInitialized)
                    CameraPreview(controller),

                  CustomPaint(
                    painter: _CameraOverlayPainter(mode: widget.mode),
                    child: const SizedBox.expand(),
                  ),

                  Center(
                    child: _FrameGuide(mode: widget.mode),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _CameraControls(
                      isCapturing: _isCapturing,
                      isFlashOn: _isFlashOn,
                      instruction: widget.instruction,
                      onFlash: widget.lensDirection == CameraLensDirection.back
                          ? _toggleFlash
                          : null,
                      onCapture: _capture,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CameraTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onHelp;

  const _CameraTopBar({
    required this.title,
    required this.onBack,
    required this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_rounded),
            color: AppColors.onSurfaceVariant,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          IconButton(
            onPressed: onHelp,
            icon: const Icon(Icons.help_outline_rounded),
            color: AppColors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _CameraControls extends StatelessWidget {
  final bool isCapturing;
  final bool isFlashOn;
  final String instruction;
  final VoidCallback? onFlash;
  final VoidCallback onCapture;

  const _CameraControls({
    required this.isCapturing,
    required this.isFlashOn,
    required this.instruction,
    required this.onFlash,
    required this.onCapture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 72, 32, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.onBackground.withValues(alpha: 0.85),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            instruction,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _RoundControlButton(
                icon: isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                onTap: onFlash,
              ),
              GestureDetector(
                onTap: isCapturing ? null : onCapture,
                child: AnimatedScale(
                  scale: isCapturing ? 0.92 : 1,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    width: 82,
                    height: 82,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.white.withValues(alpha: 0.25),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: isCapturing
                          ? const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(AppColors.white),
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.camera_alt_rounded,
                              color: AppColors.white,
                              size: AppIconSize.xl,
                            ),
                    ),
                  ),
                ),
              ),
              _RoundControlButton(
                icon: Icons.photo_library_rounded,
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _RoundControlButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.onBackground.withValues(alpha: 0.42),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(
            icon,
            color: AppColors.white,
            size: AppIconSize.md,
          ),
        ),
      ),
    );
  }
}

class _FrameGuide extends StatelessWidget {
  final D2YCameraCaptureMode mode;

  const _FrameGuide({required this.mode});

  @override
  Widget build(BuildContext context) {
    if (mode == D2YCameraCaptureMode.face) {
      return Container(
        width: 250,
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(140),
          border: Border.all(
            color: AppColors.primaryFixedDim,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryFixedDim.withValues(alpha: 0.25),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.58,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: AppColors.primaryFixedDim,
            width: 2,
          ),
        ),
        child: Stack(
          children: const [
            _CornerGuide(alignment: Alignment.topLeft),
            _CornerGuide(alignment: Alignment.topRight),
            _CornerGuide(alignment: Alignment.bottomLeft),
            _CornerGuide(alignment: Alignment.bottomRight),
            Center(
              child: Icon(
                Icons.badge_outlined,
                color: AppColors.white,
                size: 64,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CornerGuide extends StatelessWidget {
  final Alignment alignment;

  const _CornerGuide({required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 44,
        height: 44,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border(
            top: alignment.y < 0
                ? const BorderSide(color: AppColors.primaryFixedDim, width: 4)
                : BorderSide.none,
            bottom: alignment.y > 0
                ? const BorderSide(color: AppColors.primaryFixedDim, width: 4)
                : BorderSide.none,
            left: alignment.x < 0
                ? const BorderSide(color: AppColors.primaryFixedDim, width: 4)
                : BorderSide.none,
            right: alignment.x > 0
                ? const BorderSide(color: AppColors.primaryFixedDim, width: 4)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _CameraOverlayPainter extends CustomPainter {
  final D2YCameraCaptureMode mode;

  const _CameraOverlayPainter({required this.mode});

  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()
      ..color = AppColors.onBackground.withValues(alpha: 0.58);

    final clearPaint = Paint()..blendMode = BlendMode.clear;

    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawRect(Offset.zero & size, overlayPaint);

    if (mode == D2YCameraCaptureMode.face) {
      final ovalRect = Rect.fromCenter(
        center: size.center(Offset.zero),
        width: 250,
        height: 320,
      );
      canvas.drawOval(ovalRect, clearPaint);
    } else {
      final frameWidth = size.width - 48;
      final frameHeight = frameWidth / 1.58;
      final rect = Rect.fromCenter(
        center: size.center(Offset.zero),
        width: frameWidth,
        height: frameHeight,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(AppRadius.lg)),
        clearPaint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CameraOverlayPainter oldDelegate) {
    return oldDelegate.mode != mode;
  }
}

class _CameraErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CameraErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.no_photography_rounded,
              color: AppColors.white,
              size: 48,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}