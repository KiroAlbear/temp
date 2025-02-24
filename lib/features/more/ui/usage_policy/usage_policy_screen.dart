import 'package:deel/deel.dart';
import 'package:deel/features/more/ui/usage_policy/usage_policy_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/generated/l10n.dart';

class UsagePolicyScreen extends BaseStatefulWidget {
  final UsagePolicyBloc usagePolicyBloc;
  final String backIcon;
  const UsagePolicyScreen(
      {super.key, required this.usagePolicyBloc, required this.backIcon});

  @override
  State<UsagePolicyScreen> createState() => _UsagePolicyScreenState();
}

class _UsagePolicyScreenState extends BaseState<UsagePolicyScreen> {


  @override
  PreferredSizeWidget? appBar() =>null;

  @override
  bool canPop() =>true;


  @override
  bool isSafeArea() =>false;

  @override
  void onPopInvoked(didPop)  {
    changeSystemNavigationBarColor(secondaryColor);

  }

  @override
  Color? systemNavigationBarColor() => Colors.white;


  @override
  void initState() {
    widget.usagePolicyBloc.getUsagePolicy();
    super.initState();
  }

  @override
  Widget getBody(BuildContext context) {
    return Material(
      child: Column(children: [
        AppTopWidget(
          title: S.of(context).usagePolicyTitle,
          notificationIcon: '',
          homeLogo: '',
          scanIcon: '',
          searchIcon: '',
          supportIcon: '',
          hideTop: false,
          backIcon: widget.backIcon,
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: StreamBuilder<ApiState<UsagePolicyResponse>>(
              stream: widget.usagePolicyBloc.usagePolicyBehaviour,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          snapshot.data!.response!.policy!,
                          style: RegularStyle(
                                  fontSize: 18.sp, color: lightBlackColor)
                              .getStyle(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomProgress(
                          color: Theme.of(context).colorScheme.primary,
                          size: 30.r,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        )
      ]),
    );
  }


}
