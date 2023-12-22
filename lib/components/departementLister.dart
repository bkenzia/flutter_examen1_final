import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/services/departement.service.dart';

class departementLister extends StatefulWidget {
  departementLister({super.key, required this.code});
  String code;

  @override
  State<departementLister> createState() => _departementListerState();
}

class _departementListerState extends State<departementLister> {
  late Future<DepartementList?> products;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() {
    setState(() {
      products = DepartementService.getdepartements(widget.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Departement> departements = snapshot.data!.departements;
                return ListView.builder(
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
                              Text(departement.code),
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
