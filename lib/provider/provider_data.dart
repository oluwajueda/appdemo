import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderData extends ChangeNotifier {
  SharedPreferences? prefs;
  final String pageIndexKey = 'pageIndex';
  int? _pageIndex;

  ProviderData() {
    _pageIndex = 0;
    loadFromPrefs();
  }

  _initPrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  // Future<int> loadFromPrefs() async {
  //   await _initPrefs();
  //   final lastUpdatedStr = prefs!.getString('pageIndexLastUpdatedKey');
  //   if (lastUpdatedStr != null) {
  //     final lastUpdated = DateTime.parse(lastUpdatedStr);
  //     final now = DateTime.now();
  //     // creating a date without hours and minutes
  //     final today = DateTime.utc(now.year, now.month, now.day);
  //     if (lastUpdated.isAtSameMomentAs(today)) {
  //       _pageIndex = prefs!.getInt(pageIndexKey) ?? 0;

  //       notifyListeners();

  //       return _pageIndex!;
  //     }
  //   }
  //   prefs!.remove(pageIndexKey);
  //   // _pageIndex = 0;

  //   notifyListeners();
  //   return 0;
  // }

  Future<int> loadFromPrefs() async {
    await _initPrefs();
    final lastUpdatedStr = prefs!.getString('pageIndexLastUpdatedKey');
    if (lastUpdatedStr != null) {
      final lastUpdated = DateTime.parse(lastUpdatedStr);
      final now = DateTime.now();
      // creating a date without hours and minutes
      final today = DateTime.utc(now.year, now.month, now.day);
      if (lastUpdated.isAtSameMomentAs(today)) {
        _pageIndex = prefs!.getInt(pageIndexKey) ?? 0;

        notifyListeners();

        return _pageIndex!;
      }
    }
    prefs!.remove(pageIndexKey);
    _pageIndex = 0;

    notifyListeners();
    return _pageIndex!;
  }

  Future<void> _savePageIndexToPrefs(
      {required String key, required int value}) async {
    await _initPrefs();
    prefs!.setInt(key, value);
  }

  void changePageIndex(int newPageIndex) {
    _pageIndex = newPageIndex;

    _savePageIndexToPrefs(key: pageIndexKey, value: _pageIndex!);

    final now = DateTime.now();

    final today = DateTime.utc(now.year, now.month, now.day);

    prefs!.setString("pageIndexLastUpdateKey", today.toIso8601String());

    notifyListeners();
  }

  clearPageIndex() async {
    await _initPrefs();
    prefs!.clear();
  }
}
