// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/communLister.dart';
import 'package:flutter_examen1/models/departement.model.dart';

class CommunPage extends StatelessWidget {
  CommunPage({
    super.key,
    required this.departement,
    required this.title,
  });

  final String title;
  late Departement departement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: CommunLister(
            codeDepartement: departement.code,
            nameDepartement: departement.nom),
      ),
    );
  }
}
