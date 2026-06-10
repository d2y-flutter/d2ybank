import 'package:equatable/equatable.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectionResult extends Equatable {
  final bool hasFace;
  final bool hasSingleFace;
  final double? leftEyeOpenProbability;
  final double? rightEyeOpenProbability;
  final double? smilingProbability;
  final String? message;

  const FaceDetectionResult({
    required this.hasFace,
    required this.hasSingleFace,
    this.leftEyeOpenProbability,
    this.rightEyeOpenProbability,
    this.smilingProbability,
    this.message,
  });

  bool get isValidForVerification => hasFace && hasSingleFace;

  @override
  List<Object?> get props => [
        hasFace,
        hasSingleFace,
        leftEyeOpenProbability,
        rightEyeOpenProbability,
        smilingProbability,
        message,
      ];
}

class FaceDetectionService {
  final FaceDetector _detector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableClassification: true,
      enableLandmarks: true,
      enableContours: true,
    ),
  );

  Future<FaceDetectionResult> detectFromImagePath(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final faces = await _detector.processImage(inputImage);

    if (faces.isEmpty) {
      return const FaceDetectionResult(
        hasFace: false,
        hasSingleFace: false,
        message: 'Wajah tidak terdeteksi. Pastikan wajah berada di dalam bingkai.',
      );
    }

    if (faces.length > 1) {
      return const FaceDetectionResult(
        hasFace: true,
        hasSingleFace: false,
        message: 'Terdeteksi lebih dari satu wajah. Gunakan satu wajah saja.',
      );
    }

    final face = faces.first;

    return FaceDetectionResult(
      hasFace: true,
      hasSingleFace: true,
      leftEyeOpenProbability: face.leftEyeOpenProbability,
      rightEyeOpenProbability: face.rightEyeOpenProbability,
      smilingProbability: face.smilingProbability,
      message: 'Wajah berhasil terdeteksi.',
    );
  }

  Future<void> close() => _detector.close();
}