import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/features/auth/presentation/bloc/setup_pin/setup_pin_event.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:d2ybank/shared/components/feedback/d2y_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/setup_pin/setup_pin_bloc.dart';
import '../bloc/setup_pin/setup_pin_state.dart';
import '../widgets/setup_pin/pin_ambient_background.dart';
import '../widgets/setup_pin/pin_content.dart';

class SetupPinPage extends StatefulWidget {
  const SetupPinPage({super.key});

  @override
  State<SetupPinPage> createState() => _SetupPinPageState();
}

class _SetupPinPageState extends State<SetupPinPage> {
  @override
  void initState() {
    super.initState();
    context.read<SetupPinBloc>().add(const SetupPinResetRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'D2Y Bank',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<SetupPinBloc, SetupPinState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            D2YToast.error(
              context,
              title: 'PIN belum valid',
              description: state.errorMessage!,
            );
          }

          if (state.status == StateStatus.success) {
            D2YToast.success(
              context,
              title: 'PIN berhasil dibuat',
              description: 'Registrasi akun Anda berhasil diselesaikan.',
            );

            context.go(RoutePaths.registrationSuccess);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              const PinAmbientBackground(),
              PinContent(state: state),
            ],
          );
        },
      ),
    );
  }
}