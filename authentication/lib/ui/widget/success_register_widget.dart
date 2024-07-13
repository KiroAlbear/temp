import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/cupertino.dart';

class SuccessRegisterWidget extends BaseStatefulWidget {
  final String logo;
  final String successRegister;

  const SuccessRegisterWidget(
      {super.key, required this.logo, required this.successRegister});

  @override
  State<SuccessRegisterWidget> createState() => _SuccessRegisterWidgetState();
}

class _SuccessRegisterWidgetState extends BaseState<SuccessRegisterWidget> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Column(
          children: [
            SizedBox(
              height: 44.h,
            ),
            ImageHelper(
              image: widget.logo,
              imageType: ImageType.svg,
              height: 88.h,
              width: 241.w,
            ),
            SizedBox(
              height: 44.h,
            ),
            ImageHelper(
              image: widget.successRegister,
              imageType: ImageType.svg,
              height: 310.h,
              width: 310.w,
            ),
            SizedBox(
              height: 34.h,
            ),
            CustomText(
                text: S.of(context).welcomeToDokkan,
                customTextStyle:
                    SemiBoldStyle(fontSize: 26.sp, color: lightBlackColor)),
            SizedBox(
              height: 5.h,
            ),
            CustomText(
                text: S.of(context).youCanStartOrderNow,
                customTextStyle:
                    RegularStyle(fontSize: 20.sp, color: lightBlackColor)),
            SizedBox(
              height: 60.h,
            ),
            CustomButtonWidget(
              idleText: S.of(context).start,
              textStyle: SemiBoldStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
              height: 60.h,
              onTap: () => CustomNavigatorModule.navigatorKey.currentState
                  ?.pushReplacementNamed(AppScreenEnum.home.name),
            )
          ],
        ),
  );

  @override
  void onPopInvoked(didPop) {
    super.onPopInvoked(didPop);
    handleCloseApplication();
  }
}
