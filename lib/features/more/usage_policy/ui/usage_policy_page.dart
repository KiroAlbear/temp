import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsagePolicyPage extends BaseStatefulWidget {
  final UsagePolicyBloc usagePolicyBloc;

  const UsagePolicyPage({super.key, required this.usagePolicyBloc});

  @override
  State<UsagePolicyPage> createState() => _UsagePolicyScreenState();
}

class _UsagePolicyScreenState extends BaseState<UsagePolicyPage> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  void onPopInvoked(didPop) {
    changeSystemNavigationBarColor(secondaryColor);
    // super.onPopInvoked(didPop);
  }

  @override
  void initState() {
    widget.usagePolicyBloc.getUsagePolicy();
    super.initState();
  }

  @override
  Widget getBody(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AppTopWidget(
            title: Loc.of(context)!.usagePolicyTitle,
            isHavingBack: true,
          ),
          SizedBox(height: 15),
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
                              fontSize: 18.sp,
                              color: lightBlackColor,
                            ).getStyle(),
                          ),
                          SizedBox(height: 30),
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
          ),
        ],
      ),
    );
  }
}
