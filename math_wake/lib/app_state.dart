import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = const FlutterSecureStorage();
    await _safeInitAsync(() async {
      _date = await secureStorage.read(key: 'ff_date') != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (await secureStorage.getInt('ff_date'))!)
          : _date;
    });
    await _safeInitAsync(() async {
      _time = await secureStorage.read(key: 'ff_time') != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (await secureStorage.getInt('ff_time'))!)
          : _time;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? value) {
    _date = value;
    value != null
        ? secureStorage.setInt('ff_date', value.millisecondsSinceEpoch)
        : secureStorage.remove('ff_date');
  }

  void deleteDate() {
    secureStorage.delete(key: 'ff_date');
  }

  DateTime? _time;
  DateTime? get time => _time;
  set time(DateTime? value) {
    _time = value;
    value != null
        ? secureStorage.setInt('ff_time', value.millisecondsSinceEpoch)
        : secureStorage.remove('ff_time');
  }

  void deleteTime() {
    secureStorage.delete(key: 'ff_time');
  }

  String _question = '';
  String get question => _question;
  set question(String value) {
    _question = value;
  }

  String _sum = '';
  String get sum => _sum;
  set sum(String value) {
    _sum = value;
  }

  String _voiceanswer = '';
  String get voiceanswer => _voiceanswer;
  set voiceanswer(String value) {
    _voiceanswer = value;
  }
  String _level = '';
  String get level => _level;
  set level(String value) {
    _level = value;
  }
}


void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}
