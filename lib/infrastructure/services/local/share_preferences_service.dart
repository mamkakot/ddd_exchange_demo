import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  String? get token => _sharedPreferences.getString('token');

  Future<void> saveNewToken(String token) => _sharedPreferences.setString(
    'token',
    token,
  );

  Future<void> removeToken() => _sharedPreferences.remove('token');
}