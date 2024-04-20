import 'package:car/model/sharedpreferances/sharedpreferances_keys_.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSignup {
  Future saveData({required String key, required String value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future saveListSearches({required List<String> value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(SharedPreferencesKeys.listSearches, value);
  }

  static Future<String> getData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String data = sharedPreferences.get(key).toString();
    return data;
  }
}
