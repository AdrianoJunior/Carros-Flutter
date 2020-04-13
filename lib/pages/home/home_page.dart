import 'package:carros/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      drawer: DrawerList(),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Text(
        "Adriano",
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }
}
