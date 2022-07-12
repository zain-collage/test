import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image/bloc_observer.dart';

import 'package:image/gallery.dart';
import 'package:image/open.dart';

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(MyApp2());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Open(),
    );
  }
}
