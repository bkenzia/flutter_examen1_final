import 'dart:convert';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:http/http.dart' as http;

class DepartementService {
  //pour hrome
  // static String productUrl = "http://192.168.1.181:8000/products.json";
  // pour emulateur
  static String departementUrl = "https://geo.api.gouv.fr/regions/";

  static Future<DepartementList?> getdepartements(String codeRegion) async {
    try {
      final response = await http.get(
        Uri.parse(departementUrl + codeRegion + "/departements"),
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);
          final DepartementList departements =
              DepartementList.fromJson(jsonResponse);
          if (departements.departements.isNotEmpty) {
            return departements;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        throw Exception('impossible de changer les produits1');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('impossible de changer les produits2');
    }
  }
}
