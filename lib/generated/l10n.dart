// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Pill Reminder`
  String get appBarTitle {
    return Intl.message(
      'Pill Reminder',
      name: 'appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeTitle {
    return Intl.message(
      'Home',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `No Reminder`
  String get homeNoReminder {
    return Intl.message(
      'No Reminder',
      name: 'homeNoReminder',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get reminderMedicineName {
    return Intl.message(
      'Name',
      name: 'reminderMedicineName',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get reminderMedicineNote {
    return Intl.message(
      'Note',
      name: 'reminderMedicineNote',
      desc: '',
      args: [],
    );
  }

  /// `Paracematol XL2`
  String get reminderMedicine {
    return Intl.message(
      'Paracematol XL2',
      name: 'reminderMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get reminderAmount {
    return Intl.message(
      'Amount',
      name: 'reminderAmount',
      desc: '',
      args: [],
    );
  }

  /// `mg/ml`
  String get reminderMgMl {
    return Intl.message(
      'mg/ml',
      name: 'reminderMgMl',
      desc: '',
      args: [],
    );
  }

  /// `New Reminder`
  String get reminderNewReminder {
    return Intl.message(
      'New Reminder',
      name: 'reminderNewReminder',
      desc: '',
      args: [],
    );
  }

  /// `Add Reminder`
  String get reminderAddReminder {
    return Intl.message(
      'Add Reminder',
      name: 'reminderAddReminder',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get reminderType {
    return Intl.message(
      'Type',
      name: 'reminderType',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get reminderRepeat {
    return Intl.message(
      'Repeat',
      name: 'reminderRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Day`
  String get reminderRepeatDay {
    return Intl.message(
      'Repeat Day',
      name: 'reminderRepeatDay',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get reminderDay {
    return Intl.message(
      'Day',
      name: 'reminderDay',
      desc: '',
      args: [],
    );
  }

  /// `You can repeat maximum 7 days`
  String get reminderMaxRepeatDay {
    return Intl.message(
      'You can repeat maximum 7 days',
      name: 'reminderMaxRepeatDay',
      desc: '',
      args: [],
    );
  }

  /// `Please do not enter for more than 7 days.`
  String get reminderMaxRepeatDayError {
    return Intl.message(
      'Please do not enter for more than 7 days.',
      name: 'reminderMaxRepeatDayError',
      desc: '',
      args: [],
    );
  }

  /// `Certain days`
  String get reminderSelectDays {
    return Intl.message(
      'Certain days',
      name: 'reminderSelectDays',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get reminderTime {
    return Intl.message(
      'Time',
      name: 'reminderTime',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get reminderOk {
    return Intl.message(
      'Ok',
      name: 'reminderOk',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get reminderCancel {
    return Intl.message(
      'Cancel',
      name: 'reminderCancel',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLang {
    return Intl.message(
      'Language',
      name: 'settingsLang',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get settingsLanguage {
    return Intl.message(
      'English',
      name: 'settingsLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get settingsNotifications {
    return Intl.message(
      'Notifications',
      name: 'settingsNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get settingsDarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'settingsDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get settingsLightMode {
    return Intl.message(
      'Light Mode',
      name: 'settingsLightMode',
      desc: '',
      args: [],
    );
  }

  /// `Soon`
  String get settingsSoon {
    return Intl.message(
      'Soon',
      name: 'settingsSoon',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
