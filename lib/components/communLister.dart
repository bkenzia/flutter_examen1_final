// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/communs.model.dart';
import 'package:flutter_examen1/services/commun.service.dart';

class CommunLister extends StatefulWidget {
  CommunLister(
      {super.key,
      required this.codeDepartement,
      required this.nameDepartement});
  String codeDepartement;
  String nameDepartement;

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
    return FutureBuilder(
        future: communes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Communes> communes = snapshot.data!.communes;
            return Column(children: <Widget>[
              Container(
                color: Color.fromARGB(255, 200, 221, 254),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Text(
                    "Le département : ${widget.nameDepartement}(${widget.codeDepartement} compte ${communes.length} communes . Cliquez sur l'une des communes suivantes pour en savoir plus)",
                    style: const TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 18,
                    )),
              ),
              Expanded(
                  child: ListView.builder(
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

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 247, 250, 250),
                                title: const Text(
                                  "Détails de la commune",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 27, 24, 24)),
                                ),
                                content: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nom: ${commune.nom}\ncode: ${commune.code}\ncode Dep: ${commune.codeDepartement}\nsiren: ${commune.siren}\ncode Epci: ${commune.codeEpci}\npopulation: ${commune.population}\ncode postaux: ${commune.codesPostaux}",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 20, 20, 20)),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  Container(
                                    width: 100,
                                    child: FloatingActionButton(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  0, 172, 190, 200)),
                                          borderRadius:
                                              BorderRadius.circular(150)),
                                      child: const Text(
                                        "Fermer",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 76, 161, 217)),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ))
            ]);
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
