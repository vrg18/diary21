import 'package:diary/domain/deed.dart';
import 'package:intl/intl.dart';

/// данные для микро-карточки дела
class DeedBriefly {
  late String _inscription;
  final DateFormat _formatter = DateFormat.Hm();

  DeedBriefly(Deed deed) {
    this._inscription = _formatter.format(deed.dateStart) +
        (deed.dateFinish == null ? ' ' : '-${_formatter.format(deed.dateFinish!)} ') +
        '${deed.name} ';
  }

  get inscription => _inscription;
}
