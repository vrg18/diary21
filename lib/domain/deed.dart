/// сущьность Дело
class Deed {
  final String? id;
  final DateTime dateStart;
  final DateTime? dateFinish;
  final String name;
  final String? description;

  Deed({
    this.id,
    required this.dateStart,
    this.dateFinish,
    required this.name,
    this.description,
  });
}
