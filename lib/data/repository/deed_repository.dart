import 'package:diary/data/storage/deed_storage.dart';
import 'package:diary/domain/deed.dart';
import 'package:intl/intl.dart';

/// Бизнес-логика и запись/чтение в/из БД сущьности Дело
class DeedRepository {
  final String date;
  final String timeStart;
  final String? timeFinish;
  final String name;
  final String? description;
  final DateFormat _formatter = DateFormat("dd.MM.yyyy HH:mm");

  DeedRepository({
    required this.date,
    required this.timeStart,
    this.timeFinish,
    required this.name,
    this.description,
  });

  Future<String> createNewDeed(DeedStorage deedStorage) async {
    try {
      DateTime dateStart = _formatter.parse('$date $timeStart');
      DateTime? dateFinish =
          timeFinish != null && timeFinish!.isNotEmpty ? _formatter.parse('$date $timeFinish') : null;
      Deed newDeed = Deed(
        dateStart: dateStart,
        dateFinish: dateFinish,
        name: name,
        description: description,
      );
      return await deedStorage.createNewDeed(newDeed);
    } catch (e) {
      return e.toString();
    }
  }
}
