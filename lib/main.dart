import 'package:flutter/material.dart';
import 'package:todo_list/src/core/route/route_generator.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
