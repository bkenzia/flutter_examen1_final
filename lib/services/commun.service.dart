import 'dart:convert';
import 'package:flutter_examen1/models/communs.model.dart';
import 'package:http/http.dart' as http;

class CommunService {
  //pour hrome
  // static String productUrl = "http://192.168.1.181:8000/products.json";
  // pour emulateur
  static String communUrl = "https://geo.api.gouv.fr/departements/";

  static Future<CommunesList?> getcommuns(String codeDepartement) async {
    try {
      final response = await http.get(
        Uri.parse(communUrl + codeDepartement + "/communes"),
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final jsonResponse = json.decode(response.body);
          final CommunesList communes = CommunesList.fromJson(jsonResponse);
          if (communes.communes.isNotEmpty) {
            return communes;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        throw Exception('impossible de charger les communs1');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('impossible de charger les communs2');
    }
  }
}
