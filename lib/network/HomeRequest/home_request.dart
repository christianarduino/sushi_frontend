import 'package:sushi/model/Response/ResponseStatus.dart';

class HomeRequest {
  static getGroups(String userId) {
    try {} catch (e) {
      return ResponseStatus(false, "Qualcosa è andato storto. Aggiorna");
    }
  }
}
