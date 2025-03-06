import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

DatabaseFactory getDatabaseFactory() {
  if (kIsWeb) {
    return databaseFactoryFfiWeb;
  } else {
    return databaseFactory;
  }
}
