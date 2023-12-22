import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/pages/commun_page.dart';
import 'package:flutter_examen1/services/departement.service.dart';

class DepartementLister extends StatefulWidget {
  DepartementLister(
      {super.key,
      required this.code,
      required this.region,
      required this.config});
  String code;
  String region;
  final Config config;
  @override
  State<DepartementLister> createState() =>
      _DepartementListerState(config: config);
}

class _DepartementListerState extends State<DepartementLister> {
  late Future<DepartementList?> departements;
  Config config;

  _DepartementListerState({required this.config});

  @override
  void initState() {
    super.initState();
    loadDepartements();
  }

  void loadDepartements() {
    setState(() {
      departements = DepartementService.getdepartements(widget.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: departements,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Departement> departements = snapshot.data!.departements;

            return Column(
              children: <Widget>[
                Container(
                  color: Color.fromARGB(255, 200, 221, 254),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                  child: Text(
                      "La region: ${widget.region} (${widget.code}) compte ${departements.length}  départements . Cliquez sur l'un des départements pour en savoir plus  ",
                      style: const TextStyle(
                        fontFamily: 'RobotoMono',
                        fontSize: 18,
                      )),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: departements.length,
                  itemBuilder: (context, index) {
                    Departement departement = departements[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        // You can customize Card properties here
                        child: ListTile(
                          title: Text(departement.nom),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Code du département :${departement.code}"),
                            ],
                          ),
                          // You can handle onTap here
                          onTap: () {
                            // Add your onTap logic
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CommunPage(
                                        departement: departement,
                                        title:
                                            "Département :${departement.nom}",
                                      )),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ))
              ],
            );
          } else if (snapshot.hasError) {
            return Text("error: ${snapshot.error}");
          }
          return const Expanded(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }
}
