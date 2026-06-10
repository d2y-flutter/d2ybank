import 'package:camera/camera.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/services/face_detection_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/identity_verification/identity_verification_bloc.dart';
import '../bloc/identity_verification/identity_verification_event.dart';
import '../widgets/d2y_camera_capture_page.dart';

class FaceLivenessPage extends StatelessWidget {
  final FaceDetectionService faceDetectionService;

  const FaceLivenessPage({
    super.key,
    required this.faceDetectionService,
  });

  @override
  Widget build(BuildContext context) {
    return D2YCameraCapturePage(
      title: 'Verifikasi Liveness',
      instruction: 'Pastikan wajah berada di dalam bingkai oval dan pencahayaan optimal',
      mode: D2YCameraCaptureMode.face,
      lensDirection: CameraLensDirection.front,
      onCaptured: (file) async {
        final result = await faceDetectionService.detectFromImagePath(file.path);

        if (!context.mounted) return;

        if (!result.isValidForVerification) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(result.message ?? 'Verifikasi wajah gagal.'),
            ),
          );
          return;
        }

        context.read<IdentityVerificationBloc>().add(
              SubmitFaceVerificationRequested(imagePath: file.path),
            );

        context.pop();
      },
    );
  }
}