import 'package:diary/data/storage/deed_storage.dart';
import 'package:diary/domain/deed.dart';
import 'package:flutter/material.dart';

/// Бизнес-логика событий выбранного дня
/// Используется Provider
class CurrentDay with ChangeNotifier {
  late DeedStorage _deedStorage;
  bool _isLoadingNow = false;
  final Map<int, List<Deed>> _deedsOfDayByHour = {
    0: [],
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
    7: [],
    8: [],
    9: [],
    10: [],
    11: [],
    12: [],
    13: [],
    14: [],
    15: [],
    16: [],
    17: [],
    18: [],
    19: [],
    20: [],
    21: [],
    22: [],
    23: [],
  };

  Map<int, List<Deed>> get deedsOfDayByHour => _deedsOfDayByHour;

  bool get isLoadingNow => _isLoadingNow;

  DeedStorage get deedStorage => _deedStorage;

  void initDeedStorage(String token) {
    _deedStorage = DeedStorage(token);
    readDeedsOfDayByHour(DateTime.now());
  }

  Future<void> readDeedsOfDayByHour(DateTime day) async {
    _isLoadingNow = true;
    notifyListeners();
    var startOfDay = DateTime(day.year, day.month, day.day);
    var startOfNextDay = DateTime(day.year, day.month, day.day + 1);
    _deedsOfDayByHour.forEach((key, value) => value.clear());
    dynamic deeds = await _deedStorage.readDeedsOfPeriod(startOfDay, startOfNextDay);
    deeds.forEach((element) => _deedsOfDayByHour[element.dateStart.hour]!.add(element));
    _isLoadingNow = false;
    notifyListeners();
  }
}
