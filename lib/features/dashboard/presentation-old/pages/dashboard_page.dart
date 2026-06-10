import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:d2ybank/core/config/app_colors.dart';
import 'package:d2ybank/core/config/app_spacing.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:d2ybank/shared/components/feedback/d2y_loading.dart';
import 'package:d2ybank/shared/components/feedback/d2y_error_view.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/account_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/exclusive_services_carousel.dart';
import '../widgets/e_wallet_card.dart';
import '../widgets/product_grid.dart';
import '../widgets/promo_carousel.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state.status == StateStatus.loading) {
            return const D2YLoading(message: 'Loading your vault...');
          }
          if (state.status == StateStatus.failure) {
            return D2YErrorView(
              message: state.failure?.message,
              onRetry: () => context.read<DashboardCubit>().loadDashboard(),
            );
          }
          return _buildContent(context, state);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, DashboardState state) {
    return CustomScrollView(
      slivers: [
        // Glassmorphism AppBar
        const DashboardAppBar(),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: AppSpacing.lg),

              // Account balance card (gradient + glassmorphism)
              if (state.account != null)
                AccountCard(
                  account: state.account!,
                  balanceVisible: state.balanceVisible,
                  onToggleVisibility: () =>
                      context.read<DashboardCubit>().toggleBalanceVisibility(),
                ),

              const SizedBox(height: AppSpacing.xxxl),

              // Quick actions 5x2 grid
              _sectionTitle('Layanan Utama'),
              const SizedBox(height: AppSpacing.lg),
              QuickActionsGrid(actions: state.quickActions),

              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),

        // Exclusive services (horizontal scroll — full bleed)
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: _sectionTitleWithAction('Layanan Eksklusif', 'Lihat Semua'),
              ),
              const SizedBox(height: AppSpacing.md),
              ExclusiveServicesCarousel(services: state.exclusiveServices),
            ],
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          sliver: SliverList.list(
            children: [
              const SizedBox(height: AppSpacing.xxxl),

              // Bento grid: e-Wallet + Products
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // e-Wallet (left — 40%)
                  Expanded(
                    flex: 5,
                    child: EWalletCard(wallets: state.eWallets),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Products (right — 60%)
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Produk Pilihan'),
                        const SizedBox(height: AppSpacing.md),
                        ProductGrid(products: state.products),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),

        // Promo carousel (full bleed)
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: _sectionTitle('Eksklusif Untuk Anda'),
              ),
              const SizedBox(height: AppSpacing.md),
              PromoCarousel(promos: state.promos),
              const SizedBox(height: 120), // Bottom nav clearance
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'PlusJakartaSans',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _sectionTitleWithAction(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _sectionTitle(title),
        GestureDetector(
          onTap: () {},
          child: Text(
            action.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.secondary,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }
}