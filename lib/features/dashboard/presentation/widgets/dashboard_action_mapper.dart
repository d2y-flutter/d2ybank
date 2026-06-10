import 'package:flutter/material.dart';

abstract final class DashboardActionMapper {
  static const List<String> _fallbackLabels = [
    'Transfer',
    'Bayar',
    'E-Wallet',
    'Investasi',
    'Sukuk',
    'PLN',
    'Pulsa',
    'Lainnya',
  ];

  static const List<IconData> _fallbackIcons = [
    Icons.sync_alt_rounded,
    Icons.payments_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.trending_up_rounded,
    Icons.receipt_long_rounded,
    Icons.bolt_rounded,
    Icons.smartphone_rounded,
    Icons.grid_view_rounded,
  ];

  static String label(dynamic action, int index) {
    final rawLabel = _readValue(action, const [
      'label',
      'title',
      'name',
      'menuName',
    ]);

    if (rawLabel is String && rawLabel.trim().isNotEmpty) {
      return rawLabel.trim();
    }

    return _fallbackLabels[index % _fallbackLabels.length];
  }

  static IconData icon(dynamic action, int index) {
    final rawIcon = _readValue(action, const [
      'icon',
      'iconData',
      'iconName',
      'materialIcon',
    ]);

    if (rawIcon is IconData) return rawIcon;
    if (rawIcon is String) return _iconFromName(rawIcon);

    return _fallbackIcons[index % _fallbackIcons.length];
  }

  static dynamic _readValue(dynamic source, List<String> fields) {
    if (source == null) return null;

    for (final field in fields) {
      try {
        switch (field) {
          case 'label':
            return source.label;
          case 'title':
            return source.title;
          case 'name':
            return source.name;
          case 'menuName':
            return source.menuName;
          case 'icon':
            return source.icon;
          case 'iconData':
            return source.iconData;
          case 'iconName':
            return source.iconName;
          case 'materialIcon':
            return source.materialIcon;
        }
      } catch (_) {
        continue;
      }
    }

    return null;
  }

  static IconData _iconFromName(String value) {
    final normalized = value.trim().toLowerCase();

    return switch (normalized) {
      'sync_alt' || 'transfer' => Icons.sync_alt_rounded,
      'payments' || 'payment' || 'bayar' => Icons.payments_rounded,
      'account_balance_wallet' || 'wallet' || 'e-wallet' =>
        Icons.account_balance_wallet_rounded,
      'trending_up' || 'investasi' || 'investment' => Icons.trending_up_rounded,
      'receipt_long' || 'sukuk' || 'receipt' => Icons.receipt_long_rounded,
      'bolt' || 'pln' || 'electric' => Icons.bolt_rounded,
      'smartphone' || 'pulsa' || 'phone' => Icons.smartphone_rounded,
      'grid_view' || 'menu' || 'lainnya' => Icons.grid_view_rounded,
      _ => Icons.grid_view_rounded,
    };
  }
}
