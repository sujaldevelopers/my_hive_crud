import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_hive/nots_modle/notes_model.dart';
import 'package:path_provider/path_provider.dart';

import 'my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotsModelAdapter());
  await Hive.openBox<NotsModel>('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
//Step 1
// WidgetsFlutterBinding.ensureInitialized();
// var directory = await getApplicationDocumentsDirectory();
// Hive.init(directory.path);
// Hive.registerAdapter(NotsModelAdapter());
// await Hive.openBox<NotsModel>("notes");
//also creat notsmodul class run Command: flutter packages pub run build_runner build
