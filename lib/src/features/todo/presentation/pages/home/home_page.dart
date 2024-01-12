import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1,
              child: ListTile(
                title: Text("Todo"),
                subtitle: Text("Need to do this things"),
                trailing: Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                onTap: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
