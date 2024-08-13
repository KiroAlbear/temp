import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/alert_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:flutter/material.dart';

class BottomNavigationBloc extends BlocBase {
  final BehaviorSubject<int> _selectedTabBehaviour = BehaviorSubject();
  final Widget loginWidget;
  List<Widget> widgetList = [];

  Stream<int> get selectedTabStream => _selectedTabBehaviour.stream;

  int get selectedTab => _selectedTabBehaviour.value;

  void setSelectedTab(int value, BuildContext? context) {
    if ((value == 1 || value == 3) &&
        (SharedPrefModule().userId ?? '').isEmpty) {
      if (context != null) {
        AlertModule().showDialog(
          context: context,
          message: S.of(context).youNeedToLoginToUseApp,
          onConfirm: () {
            Future.delayed(const Duration(milliseconds: 600)).then(
              (value) {
                CustomNavigatorModule.navigatorKey.currentState
                    ?.pushReplacementNamed(AppScreenEnum.splash.name);
              },
            );
          },
          cancelMessage: S.of(context).cancel,
        );
      }
    } else {
      _selectedTabBehaviour.sink.add(value);
    }
  }

  BottomNavigationBloc(this.widgetList, this.loginWidget) {
    _selectedTabBehaviour.sink.add(0);
  }

  @override
  void dispose() {
    /// disabled dispose due work of it as shared bloc
    // _selectedTabBehaviour.close();
  }
}
