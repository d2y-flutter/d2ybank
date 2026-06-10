import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:d2ybank/shared/components/feedback/d2y_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/setup_password/setup_password_bloc.dart';
import '../bloc/setup_password/setup_password_state.dart';
import '../widgets/setup_password/setup_password_content.dart';

class SetupPasswordPage extends StatefulWidget {
  const SetupPasswordPage({super.key});

  @override
  State<SetupPasswordPage> createState() => _SetupPasswordPageState();
}

class _SetupPasswordPageState extends State<SetupPasswordPage> {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<SetupPasswordBloc, SetupPasswordState>(
        listener: (context, state) {
          if (state.generalError != null) {
            D2YToast.error(
              context,
              title: 'Password belum valid',
              description: state.generalError!,
            );
          }

          if (state.status == StateStatus.success) {
            D2YToast.success(
              context,
              title: 'Password berhasil dibuat',
              description: 'Lanjutkan dengan membuat PIN transaksi.',
            );

            context.go(RoutePaths.setupPin);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xl,
              AppSpacing.md,
              120,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: SetupPasswordContent(
                  state: state,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}