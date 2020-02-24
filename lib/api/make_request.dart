import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'errors.dart';
import 'dart:io' show SocketException, HttpException;
import 'package:http/http.dart' as http;

class MakeRequest {
  static String url = DotEnv().env['SERVER_URL'];

  static Future get(String endpoint, Map<String, String> params) async {
    try {
      Uri uri = Uri.https(url, endpoint, params);
      http.Response response = await http.get(uri);
      final responseJson = await jsonDecode(response.body);
      return responseJson;
    } on SocketException {
      throw NoInternetException(
        "Nessuna connesione internet.\nAssicurati di avere il wifi o la connessione dati attiva",
      );
    } on HttpException {
      print("FROM HTTP EXCEPTION");
      throw NoServiceFoundException("Si è verificato un errore. Riprova");
    } on FormatException {
      print("FROM FORMAT EXCEPTION");
      throw InvalidFormatException(
        "C'è un errore nei dati.",
      );
    } catch (e) {
      print(e);
      throw UnknownException("Si è verificato un errore. Riprova");
    }
  }

  static Future post(String endpoint, Map<String, String> body) async {
    try {
      print(url + endpoint);
      print(body);
      http.Response response = await http.post(url + endpoint, body: body);
      print(response.body);
      final responseJson = await jsonDecode(response.body);
      return responseJson;
    } on SocketException {
      throw NoInternetException(
        "Nessuna connesione internet.\nAssicurati di avere il wifi o la connessione dati attiva",
      );
    } on HttpException {
      print("FROM HTTP EXCEPTION");
      throw NoServiceFoundException("Si è verificato un errore. Riprova");
    } on FormatException {
      print("FROM FORMAT EXCEPTION");
      throw InvalidFormatException(
        "C'è un errore nei dati.",
      );
    } catch (e) {
      print(e);
      throw UnknownException("Si è verificato un errore. Riprova");
    }
  }

  static Future put(String endpoint, Map<String, String> body) async {
    try {
      http.Response response = await http.put(url + endpoint, body: body);
      final responseJson = await jsonDecode(response.body);
      return responseJson;
    } on SocketException {
      throw NoInternetException(
        "Nessuna connesione internet.\nAssicurati di avere il wifi o la connessione dati attiva",
      );
    } on HttpException {
      print("FROM HTTP EXCEPTION");
      throw NoServiceFoundException("Si è verificato un errore. Riprova");
    } on FormatException {
      print("FROM FORMAT EXCEPTION");
      throw InvalidFormatException(
        "C'è un errore nei dati.",
      );
    } catch (e) {
      print(e);
      throw UnknownException("Si è verificato un errore. Riprova");
    }
  }

  static Future delete(String endpoint, Map<String, String> body) async {
    try {
      http.Response response = await http.delete(url + endpoint);
      final responseJson = await jsonDecode(response.body);
      return responseJson;
    } on SocketException {
      throw NoInternetException(
        "Nessuna connesione internet.\nAssicurati di avere il wifi o la connessione dati attiva",
      );
    } on HttpException {
      print("FROM HTTP EXCEPTION");
      throw NoServiceFoundException("Si è verificato un errore. Riprova");
    } on FormatException {
      print("FROM FORMAT EXCEPTION");
      throw InvalidFormatException(
        "C'è un errore nei dati.",
      );
    } catch (e) {
      print(e);
      throw UnknownException("Si è verificato un errore. Riprova");
    }
  }
}
