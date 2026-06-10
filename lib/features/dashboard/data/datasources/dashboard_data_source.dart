import 'dart:ui';
import '../../domain/entities/dashboard_entities.dart';

/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/// DUMMY DATA SOURCE — Replace with real API later
///
/// Each method maps 1:1 to a backend endpoint.
/// Backend team: implement these contracts:
///   GET /dashboard/account
///   GET /dashboard/quick-actions
///   GET /dashboard/exclusive-services
///   GET /dashboard/e-wallets
///   GET /dashboard/promos
///   GET /dashboard/products
/// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

abstract class DashboardDataSource {
  Future<AccountEntity> getAccount();
  Future<List<QuickActionEntity>> getQuickActions();
  Future<List<ExclusiveServiceEntity>> getExclusiveServices();
  Future<List<EWalletEntity>> getEWallets();
  Future<List<PromoEntity>> getPromos();
  Future<List<ProductEntity>> getProducts();
}

class DashboardDummyDataSource implements DashboardDataSource {
  @override
  Future<AccountEntity> getAccount() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const AccountEntity(
      id: 'acc_001',
      accountNumber: '123-456-7890',
      holderName: 'Rizky Adriansyah',
      balance: 25500000,
      currency: 'IDR',
      avatarUrl: 'https://i.pravatar.cc/300?u=rizky',
    );
  }

  @override
  Future<List<QuickActionEntity>> getQuickActions() async {
    return const [
      QuickActionEntity(id: '1', label: 'Transfer', iconName: 'swap_horiz', route: '/transfer'),
      QuickActionEntity(id: '2', label: 'Bayar V/A', iconName: 'account_balance', route: '/pay-va'),
      QuickActionEntity(id: '3', label: 'Topup', iconName: 'add_circle', route: '/topup'),
      QuickActionEntity(id: '4', label: 'eMoney', iconName: 'contactless', route: '/emoney'),
      QuickActionEntity(id: '5', label: 'Tarik Tunai', iconName: 'local_atm', route: '/withdraw'),
      QuickActionEntity(id: '6', label: 'Valas', iconName: 'currency_exchange', route: '/forex'),
      QuickActionEntity(id: '7', label: 'Tagihan', iconName: 'receipt_long', route: '/bills'),
      QuickActionEntity(id: '8', label: 'Tap to Pay', iconName: 'nfc', route: '/tap-pay'),
      QuickActionEntity(id: '9', label: 'QR Terima', iconName: 'qr_code_2', route: '/qr-receive'),
      QuickActionEntity(id: '10', label: 'Lainnya', iconName: 'grid_view', route: '/more'),
    ];
  }

  @override
  Future<List<ExclusiveServiceEntity>> getExclusiveServices() async {
    return const [
      ExclusiveServiceEntity(
        id: '1', title: 'Wealth Advisory',
        description: 'Personalized investment strategies crafted for your financial growth by our expert advisors.',
        iconName: 'diamond', badge: 'Priority',
      ),
      ExclusiveServiceEntity(
        id: '2', title: 'Global Lounge Access',
        description: 'Experience ultimate comfort with complimentary access to 1,200+ airport lounges worldwide.',
        iconName: 'flight_takeoff',
      ),
      ExclusiveServiceEntity(
        id: '3', title: 'Concierge 24/7',
        description: 'Dedicated personal concierge for travel, dining, and lifestyle arrangements around the clock.',
        iconName: 'support_agent', badge: 'Exclusive',
      ),
    ];
  }

  @override
  Future<List<EWalletEntity>> getEWallets() async {
    return const [
      EWalletEntity(id: '1', name: 'GoPay', balance: 1250000, color: Color(0xFF00BAF2), abbreviation: 'Go'),
      EWalletEntity(id: '2', name: 'OVO', balance: 420500, color: Color(0xFF4E2A84), abbreviation: 'O'),
      EWalletEntity(id: '3', name: 'DANA', balance: 89000, color: Color(0xFF118EEA), abbreviation: 'D'),
    ];
  }

  @override
  Future<List<PromoEntity>> getPromos() async {
    return const [
      PromoEntity(
        id: '1', title: 'Discount up to 50% at Artisan Cafes',
        subtitle: 'Privileged dining for Priority members only',
        category: 'KULINER',
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=600',
        overlayColor: Color(0xFF001E40),
      ),
      PromoEntity(
        id: '2', title: 'Luxury Getaway Rewards',
        subtitle: 'Earn double miles on international bookings',
        category: 'TRAVEL',
        imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
        overlayColor: Color(0xFF006B5C),
      ),
    ];
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    return const [
      ProductEntity(id: '1', title: 'Reksa Dana Growth Pro', category: 'Investasi',
        imageUrl: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=600'),
      ProductEntity(id: '2', title: 'KPR Azure Fixed Elite', category: 'Kredit',
        imageUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600'),
    ];
  }
}