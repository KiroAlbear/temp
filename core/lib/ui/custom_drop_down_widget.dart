import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatefulWidget {
  final List<DropDownMapper> dropDownList;
  final ValueChanged<DropDownMapper> onSelect;
  final String headerText;

  const CustomDropDownWidget(
      {super.key,
      required this.dropDownList,
      required this.onSelect,
      required this.headerText});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  @override
  Widget build(BuildContext context) => BottomSheet(
        enableDrag: false,
        showDragHandle: false,
        clipBehavior: Clip.none,
        onClosing: () => Navigator.pop(context),
        builder: (context) => Container(
          decoration: leftRadiusWhiteBorder,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 26.h,
              ),
              _headerText,
              SizedBox(
                height: 16.h,
              ),
              _buildList,
              SizedBox(height: 20.h,),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      );

  Widget get _headerText => CustomText(
      text: widget.headerText,
      customTextStyle: MediumStyle(fontSize: 26.sp, color: secondaryColor));

  Widget get _buildList => Expanded(
    child: ListView.separated(
          itemBuilder: (context, index) => _item(widget.dropDownList[index]),
          scrollDirection: Axis.vertical,
          itemCount: widget.dropDownList.length,
          shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: 8.h,),
        ),
  );

  Widget _item(DropDownMapper item) => InkWell(
        onTap: () {
          widget.onSelect(item);
          Navigator.pop(context);
        },
        child: Container(
          decoration: grayRectangleBorder,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.5.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageHelper(
                image: item.image,
                imageType: ImageType.network,
                width: 40.w,
                height: 26.h,
                boxFit: BoxFit.fill,
              ),
              SizedBox(width: 16.w,),
              CustomText(
                  text: item.name,
                  customTextStyle:
                      RegularStyle(color: secondaryColor, fontSize: 16.sp))
            ],
          ),
        ),
      );
}
