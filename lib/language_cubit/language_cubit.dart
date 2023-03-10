import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../core/app/language.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState());

  void setArabic() {
    emit(const LanguageState(locale: arabicLocale));
  }

  void setEnglish() {
    emit(const LanguageState(locale: englishLocale));
  }
}
