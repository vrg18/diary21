import 'package:diary/data/storage/deed_storage.dart';
import 'package:diary/domain/deed.dart';

/// Бизнес-логика событий выбранного дня
/// Используется Provider
class CurrentDay {
//  late DateTime _currentDay;
  late DeedStorage _deedStorage;
//  late List<Deed> _deedsOfDay;
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

  // CurrentDay() {
  //   var _now = DateTime.now();
  //   _currentDay = DateTime(_now.year, _now.month, _now.day);
  // }

  Map<int, List<Deed>> get deedsOfDayByHour => _deedsOfDayByHour;

  void initDeedStorage(String token) {
    _deedStorage = DeedStorage(token);
  }

  Future<Map<int, List<Deed>>> getDeedsOfDayByHour(DateTime day) async {
    var dayWithoutHours = DateTime(day.year, day.month, day.day);
    var deedsOfDay = await _deedStorage.readDeedsOfDay(dayWithoutHours);
//    List<Deed> deedsOfDay = [];
    _deedsOfDayByHour.forEach((key, value) => value.clear());
    deedsOfDay.forEach((element) => _deedsOfDayByHour[element.dateStart.hour]!.add(element));
    return _deedsOfDayByHour;
  }
}
