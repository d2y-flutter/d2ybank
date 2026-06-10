import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/identity_verification/identity_verification_bloc.dart';
import '../bloc/identity_verification/identity_verification_event.dart';
import '../widgets/d2y_camera_capture_page.dart';

class KtpCameraPage extends StatelessWidget {
  const KtpCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return D2YCameraCapturePage(
      title: 'Foto KTP',
      instruction: 'Posisikan KTP Anda di dalam bingkai',
      mode: D2YCameraCaptureMode.ktp,
      lensDirection: CameraLensDirection.back,
      onCaptured: (file) {
        context.read<IdentityVerificationBloc>().add(
              SubmitKtpPhotoRequested(imagePath: file.path),
            );

        context.pop();
      },
    );
  }
}