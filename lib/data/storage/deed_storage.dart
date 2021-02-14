import 'package:diary/data/res/properties.dart';
import 'package:diary/domain/deed.dart';
import 'package:postgrest/postgrest.dart';

class DeedStorage {
  late PostgrestClient _client;

  DeedStorage(token) {
    _client = PostgrestClient(
      urlData,
    ).auth(token);
  }

  dynamic readDeedsOfPeriod(DateTime startDay, DateTime finishDay) async {
    var response = await _client
        .from(tableName)
        .select()
        .or('and(date_start.gte.$startDay},date_start.lt.$finishDay)')
        .order('date_start', ascending: true)
        .order('date_finish', ascending: true)
        .execute();
    if (response.error == null) {
      return response.data.map((element) {
        return Deed(
          idS: element['id'],
          dateStart: DateTime.parse(element['date_start']),
          dateFinish: DateTime.parse(element['date_finish']),
          name: element['name'],
          description: element['description'],
        );
      }).toList();
    } else {
      return [];
    }
  }
}
