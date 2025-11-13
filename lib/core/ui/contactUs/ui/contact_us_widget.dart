import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsWidget extends StatefulWidget {
  final ContactUsBloc contactUsBloc;

  const ContactUsWidget({super.key, required this.contactUsBloc});

  @override
  State<ContactUsWidget> createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget>
    with ResponseHandlerModule {
  @override
  Widget build(BuildContext context) => StreamBuilder<ApiState<ContactUsMapper>>(
    stream: widget.contactUsBloc.contactUsStream,
    builder: (context, snapshot) {
      if (snapshot.data == null) {
        return const SizedBox();
      } else
        return checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            onSuccess: _buildScreenDesign(snapshot.data!.response!));
    },
  );

  Widget _buildScreenDesign(ContactUsMapper contactUsMapper) => Column(
    mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 39.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 90.w,
              ),
              CustomText(
                  text: S.of(context).howCanWeHelp,
                  customTextStyle:
                      BoldStyle(fontSize: 18.sp, color: lightBlackColor)),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: ImageHelper(
                  image:  Assets.svg.icClose,
                  imageType: ImageType.svg,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
              SizedBox(
                width: 16.w,
              )
            ],
          ),
          SizedBox(
            height: 17.h,
          ),
          InkWell(
            onTap: () => EasyLauncher.call(number: contactUsMapper.hotLine),
            child: _buildContactUsItem(contactUsMapper.hotLine, Assets.svg.icPhone, S.of(context).hotline),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () async {
              await launchUrl(Uri.parse(contactUsMapper.whatsApp));
              // EasyLauncher.sendToWhatsApp(
              //     phone: contactUsMapper.whatsApp, message: 'Hi')
            },
            child: _buildContactUsItem(contactUsMapper.whatsApp,
                Assets.svg.icWhatsApp, S.of(context).whatsApp),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () => EasyLauncher.url(
                url: contactUsMapper.facebook, mode: Mode.externalApp),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: _buildContactUsItem(contactUsMapper.facebook,
                  Assets.svg.icFaceBook, S.of(context).faceBook),
            ),
          ),
          // SizedBox(
          //   height: 50.h,
          // ),
          SizedBox(
            height: 25.h,
          ),
        ],
      );

  Widget _buildContactUsItem(String linkTo, String imagePath, String text) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 47.w,
          ),
          ImageHelper(
            image: imagePath,
            imageType: ImageType.svg,
            width: 24.w,
            height: 24.h,
            boxFit: BoxFit.contain,
          ),
          SizedBox(
            width: 35.w,
          ),
          CustomText(
              text: text,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 18.sp))
        ],
      );
}
