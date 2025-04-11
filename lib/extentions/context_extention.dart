import 'package:flutter/widgets.dart'; // Для использования BuildContext
import 'package:vk/l10n/generated/app_localizations.dart'; // Импортируем файл с локализациями

// Создаём расширение на BuildContext
extension LocalizationExtension on BuildContext {
  AppLocalizations get loc {
    return AppLocalizations.of(this);
  }
}