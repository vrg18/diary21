import 'package:diary/data/res/properties.dart';
import 'package:diary/domain/deed.dart';
import 'package:postgrest/postgrest.dart';

class DeedStorage {
  final String _token;
  late PostgrestClient _client;

  DeedStorage(this._token) {
    _client = PostgrestClient(
      urlData,
    ).auth(_token);
  }

  Future<List<Deed>> readDeedsOfDay(DateTime day) async {
    var response = await _client
        .from(tableName)
        .select()
        .order('date_start', ascending: true)
        .order('date_finish', ascending: true)
        .execute();
    if (response.error == null) {
      return response.data;
    } else {
      return [];
    }
  }
}
