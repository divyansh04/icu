import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtility {
  static final String kOnBoardingStatus = 'onBoardingStatus';

  static SharedPreferences _preferences;

  /// Contains [bool] value about onboarding screen visited
  static const String ONBOARDING_KEY = 'onboarding flag';

  Future<void> markOnBoardingAsVisited({bool visited = true}) async {
    assert(visited != null);
    await _preferences.setBool(ONBOARDING_KEY, visited);
  }

  /// returns true if onBoarding screen is visited
  bool checkIfOnBoardingVisited() {
    try {
      return _preferences.getBool(ONBOARDING_KEY) ?? false;
    } catch (e) {
      return false;
    }
  }
}
