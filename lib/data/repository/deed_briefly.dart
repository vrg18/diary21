import 'package:diary/domain/deed.dart';

/// данные для микро-карточки дела
class DeedBriefly {
  late String _inscription;

  DeedBriefly(Deed deed) {
    this._inscription =
        deed.dateStart.toString() + (deed.dateFinish == null ? '  ' : '-${deed.dateFinish.toString()}  ') + deed.name;
  }

  get inscription => _inscription;
}
