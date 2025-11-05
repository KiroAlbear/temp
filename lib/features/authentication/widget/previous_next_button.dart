import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class PreviousNextButton extends StatelessWidget {
  final isPrevious;
  final Stream<bool> isButtonEnabledStream;
  final Stream<ButtonState>? buttonStateStream;
  final void Function() onTap;
  const PreviousNextButton({super.key,required this.isPrevious,required this.isButtonEnabledStream,required this.onTap,this.buttonStateStream });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: isButtonEnabledStream,
      builder: (context, snapshot) {
        return StreamBuilder<ButtonState>(
          stream: buttonStateStream??const Stream.empty(),
          builder: (context, snapshot2) {
            return snapshot2.data == ButtonState.loading? CustomProgress(color: darkSecondaryColor,size: 30,):InkWell(
              onTap: onTap,
              child: Directionality(
                textDirection: isPrevious? TextDirection.rtl:TextDirection.ltr,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageHelper(
                      image:isPrevious? Assets.svg.icPreviousBlue:Assets.svg.icForwardGrey,
                      imageType: ImageType.svg,
                      color:isPrevious? darkSecondaryColor: snapshot.data == true ? darkSecondaryColor: greyColor ,
                      width: 22.w,
                      height: 22.h,
                    ),
                    SizedBox(width: 4), // Add spacing between the text and the icon
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: CustomText(
                        text:isPrevious? S.of(context).previous:S.of(context).next,
                        customTextStyle: RegularStyle(
                          fontSize: 16.sp,
                          color: isPrevious? darkSecondaryColor: snapshot.data == true ? darkSecondaryColor: greyColor, // Use your desired color
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

    );;
  }
}
