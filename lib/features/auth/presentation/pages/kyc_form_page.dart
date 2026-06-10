import 'package:d2ybank/app/navigation/route_paths.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/core/config/app_text_styles.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:d2ybank/shared/components/feedback/d2y_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/kyc/kyc_bloc.dart';
import '../bloc/kyc/kyc_state.dart';
import '../widgets/kyc/kyc_content.dart';

class KycFormPage extends StatefulWidget {
  const KycFormPage({super.key});

  @override
  State<KycFormPage> createState() => _KycFormPageState();
}

class _KycFormPageState extends State<KycFormPage> {
  late final TextEditingController nikController;
  late final TextEditingController fullNameController;
  late final TextEditingController placeOfBirthController;
  late final TextEditingController addressController;
  late final TextEditingController religionController;

  @override
  void initState() {
    super.initState();

    final state = context.read<KycBloc>().state;

    nikController = TextEditingController(text: state.nik);
    fullNameController = TextEditingController(text: state.fullName);
    placeOfBirthController = TextEditingController(text: state.placeOfBirth);
    addressController = TextEditingController(text: state.address);
    religionController = TextEditingController(text: state.religion);
  }

  @override
  void dispose() {
    nikController.dispose();
    fullNameController.dispose();
    placeOfBirthController.dispose();
    addressController.dispose();
    religionController.dispose();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<KycBloc, KycState>(
        listener: (context, state) {
          if (state.generalError != null) {
            D2YToast.error(
              context,
              title: 'Data belum valid',
              description: state.generalError!,
            );
          }

          if (state.status == StateStatus.success) {
            D2YToast.success(
              context,
              title: 'Data berhasil disimpan',
              description: 'Proses KYC Anda berhasil dilanjutkan.',
            );

            context.go(RoutePaths.home);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.massive,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: KycContent(
                  state: state,
                  nikController: nikController,
                  fullNameController: fullNameController,
                  placeOfBirthController: placeOfBirthController,
                  addressController: addressController,
                  religionController: religionController,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}