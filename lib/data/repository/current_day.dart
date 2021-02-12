import 'package:diary/domain/deed.dart';

/// Бизнес-логика событий выбранного дня
/// Используется Provider
class CurrentDay {
  late DateTime _currentDay;
  late List<Deed> _deedsOfDay;
  Map<int, List<Deed>> _deedsOfDayByHour = {
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

  CurrentDay() {
    var _now = new DateTime.now();
    _currentDay = new DateTime(_now.year, _now.month, _now.day);
    _getDeedsOfDayByHour();
  }

  Map<int, List<Deed>> get deedsOfDayByHour => _deedsOfDayByHour;

  _getDeedsOfDayByHour() {
    _deedsOfDay = []; // todo взять из базы
    _deedsOfDayByHour.forEach((key, value) => value.clear());
    _deedsOfDay.forEach((element) => _deedsOfDayByHour[element.dateStart.hour]!.add(element));
    return _deedsOfDayByHour;
  }
}
