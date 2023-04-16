import 'package:shared_preferences/shared_preferences.dart';

class Session {
  late SharedPreferences preferences;

  saveId(int id) async {
    preferences = await SharedPreferences.getInstance();
    return await preferences.setInt("user", id);
  }

  Future<int?> readId() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt("user");
  }

  deleteId() async {
    preferences = await SharedPreferences.getInstance();
    return await preferences.remove("user");
  }
}
