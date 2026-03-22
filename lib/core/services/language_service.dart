import 'dart:ui';
import '../constants/storage_keys.dart';
import 'local_storage_service.dart';

abstract class LanguageService {
  Future<void> init();
  Locale get currentLocale;
  Future<void> setLocale(Locale locale);
  List<Locale> get supportedLocales;
}

class LanguageServiceImpl implements LanguageService {
  final LocalStorageService _localStorage;
  Locale _currentLocale = const Locale('en');

  LanguageServiceImpl({required LocalStorageService localStorage}) : _localStorage = localStorage;

  @override
  Future<void> init() async {
    final saved = _localStorage.getString(StorageKeys.languageCode);
    if (saved != null) _currentLocale = Locale(saved);
  }

  @override
  Locale get currentLocale => _currentLocale;

  @override
  Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;
    await _localStorage.setString(StorageKeys.languageCode, locale.languageCode);
  }

  @override
  List<Locale> get supportedLocales => const [Locale('en'), Locale('id')];
}
