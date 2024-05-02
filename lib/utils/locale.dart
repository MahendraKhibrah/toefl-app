import 'dart:io';

enum LocaleEnum { id, en }

String getLocaleName() {
  if (isLocaleBahasa()) {
    return 'id';
  } else {
    return 'en';
  }
}

bool isLocaleBahasa() => Platform.localeName.toLowerCase().startsWith('id');

