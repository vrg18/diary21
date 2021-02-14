/// сущьность Дело
class Deed {
  final String? idS;
  final DateTime dateStart;
  final DateTime? dateFinish;
  final String name;
  final String? description;

  Deed({this.idS,
    required this.dateStart,
    this.dateFinish,
    required this.name,
    this.description,
  });
}
