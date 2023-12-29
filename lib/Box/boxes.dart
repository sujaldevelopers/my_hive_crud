import 'package:hive/hive.dart';

import '../nots_modle/notes_model.dart';

class Boxes{
static Box<NotsModel>getData()=>Hive.box<NotsModel>('notes');
}