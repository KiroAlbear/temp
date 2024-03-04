import 'package:core/core.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/material.dart';

class BottomNavigationBloc extends BlocBase {
  final BehaviorSubject<int> _selectedTabBehaviour = BehaviorSubject();
  List<Widget> widgetList = [];

  Stream<int> get selectedTabStream => _selectedTabBehaviour.stream;

  int get selectedTab => _selectedTabBehaviour.value;

  void setSelectedTab(int value) {
    _selectedTabBehaviour.sink.add(value);
  }

  BottomNavigationBloc(this.widgetList) {
    _selectedTabBehaviour.sink.add(0);
  }

  @override
  void dispose() {
    /// disabled dispose due work of it as shared bloc
    // _selectedTabBehaviour.close();
  }
}
