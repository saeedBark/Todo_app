import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/todo_app/todo.dart';
import 'package:todo_app/styles/bloc_observ.dart';

void main() {

    Bloc.observer = MyBlocObserver();
    runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: HomeLayout(),
    );
  }
}
