import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'Model/note_data.dart';
import 'Pages/home_page.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("note_database",);
  runApp(Notes());
}

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => NoteData(),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomePage(),

            ));
  }
}
