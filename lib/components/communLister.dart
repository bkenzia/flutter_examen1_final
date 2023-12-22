import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/communs.model.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/services/commun.service.dart';
import 'package:flutter_examen1/services/departement.service.dart';

class CommunLister extends StatefulWidget {
  CommunLister({super.key, required this.codeDepartement});
  String codeDepartement;

  @override
  State<CommunLister> createState() => _CommunListerState();
}

class _CommunListerState extends State<CommunLister> {
  late Future<CommunesList?> communes;

  @override
  void initState() {
    super.initState();
    loadCommuns();
  }

  void loadCommuns() {
    setState(() {
      communes = CommunService.getcommuns(widget.codeDepartement);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
            future: communes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Communes> communes = snapshot.data!.communes;
                return ListView.builder(
                  itemCount: communes.length,
                  itemBuilder: (context, index) {
                    Communes commune = communes[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        // You can customize Card properties here
                        child: ListTile(
                          title: Text(commune.nom),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(commune.code),
                            ],
                          ),
                          // You can handle onTap here
                          onTap: () {
                            // Add your onTap logic
                          },
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("error: ${snapshot.error}");
              }
              return const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }));
  }
}
