import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class PreviousNextButton extends StatelessWidget {
  final bool isPrevious;
  final Stream<bool> isButtonEnabledStream;
  final Stream<ButtonState>? buttonStateStream;
  final void Function() onTap;
  const PreviousNextButton({
    super.key,
    required this.isPrevious,
    required this.isButtonEnabledStream,
    required this.onTap,
    this.buttonStateStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: isButtonEnabledStream,
      builder: (context, snapshot) {
        return StreamBuilder<ButtonState>(
          stream: buttonStateStream ?? const Stream.empty(),
          builder: (context, snapshot2) {
            return snapshot2.data == ButtonState.loading
                ? CustomProgress(color: secondaryColor, size: 30)
                : InkWell(
                    onTap: snapshot.data == true ? onTap : null,
                    child: Directionality(
                      textDirection: isPrevious
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageHelper(
                            image: isPrevious
                                ? Assets.svg.icPreviousBlue
                                : Assets.svg.icForwardGrey,
                            imageType: ImageType.svg,
                            color: isPrevious
                                ? secondaryColor
                                : snapshot.data == true
                                ? secondaryColor
                                : greyColor,
                            width: 22.w,
                            height: 22.h,
                          ),
                          const SizedBox(
                            width: 8,
                          ), // Add spacing between the text and the icon
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: CustomText(
                              text: isPrevious
                                  ? Loc.of(context)!.previous
                                  : Loc.of(context)!.next,
                              customTextStyle: RegularStyle(
                                fontSize: 16.sp,
                                color: isPrevious
                                    ? secondaryColor
                                    : snapshot.data == true
                                    ? secondaryColor
                                    : greyColor, // Use your desired color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
