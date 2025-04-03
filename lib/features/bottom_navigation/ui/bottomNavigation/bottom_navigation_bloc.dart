import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BottomNavigationBloc extends BlocBase {
  final BehaviorSubject<int> _selectedTabBehaviour = BehaviorSubject();
  Stream<int> get selectedTabStream => _selectedTabBehaviour.stream;
  int get selectedTab => _selectedTabBehaviour.value;

  void setSelectedTab(int value, BuildContext? context) {
    if ((value == 1 || value == 3) &&
        (SharedPrefModule().userId ?? '').isEmpty) {
      if (context != null) {
        Apputils.showNeedToLoginDialog(context);
      }
    } else {
      _selectedTabBehaviour.sink.add(value);
    }
  }

  BottomNavigationBloc() {
    _selectedTabBehaviour.sink.add(0);
  }

  @override
  void dispose() {
    /// disabled dispose due work of it as shared bloc
    // _selectedTabBehaviour.close();
  }
}
