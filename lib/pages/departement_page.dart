import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/departementLister.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';

class DepartementPage extends StatelessWidget {
  DepartementPage({
    super.key,
    required this.config,
    required this.title,
  });

  final Config config;
  final String title;
  late String code;

  String getCodeRegion(title) {
    String region = title.split(':')[1];
    code = config.get('regions.$region.code');
    print("le code est : $code");

    return code;
  }

  String getRegion(title) {
    return title.split(':')[1];
  }

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
      drawer: SlideMenu(
          config: config, currentPage: config.get('page-name.regions')),
      body: Center(
        child: DepartementLister(
            code: getCodeRegion(title),
            region: getRegion(title),
            config: config),
      ),
    );
  }
}
