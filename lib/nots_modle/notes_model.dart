import 'package:hive/hive.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotsModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String dropdown;

  NotsModel(
      {required this.title, required this.description, required this.dropdown});
}
