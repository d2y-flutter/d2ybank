import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:d2ybank/shared/components/feedback/d2y_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/biometric_setup/biometric_setup_bloc.dart';
import '../bloc/biometric_setup/biometric_setup_event.dart';
import '../bloc/biometric_setup/biometric_setup_state.dart';
import '../widgets/biometric_setup/biometric_content.dart';

class BiometricSetupPage extends StatefulWidget {
  const BiometricSetupPage({super.key});

  @override
  State<BiometricSetupPage> createState() => _BiometricSetupPageState();
}

class _BiometricSetupPageState extends State<BiometricSetupPage> {
  @override
  void initState() {
    super.initState();
    context.read<BiometricSetupBloc>().add(const BiometricSetupStarted());
  }

  void _goNext() {
    context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'd2ybank',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BiometricSetupBloc, BiometricSetupState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            D2YToast.error(
              context,
              title: 'Biometrik gagal diproses',
              description: state.errorMessage!,
            );
          }

          if (state.status == StateStatus.success) {
            D2YToast.success(
              context,
              title: state.isEnabled
                  ? '${state.biometricLabel} aktif'
                  : 'Biometrik dilewati',
              description: state.isEnabled
                  ? 'Anda dapat menggunakan biometrik untuk login berikutnya.'
                  : 'Anda tetap dapat mengaktifkannya nanti di menu pengaturan.',
            );

            _goNext();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xl,
              AppSpacing.md,
              AppSpacing.xxl,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: BiometricContent(state: state),
              ),
            ),
          );
        },
      ),
    );
  }
}