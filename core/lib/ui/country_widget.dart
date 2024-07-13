import 'package:core/core.dart';
import 'package:core/dto/commonBloc/drop_down_bloc.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_drop_down_widget.dart';
import 'package:flutter/material.dart';

import '../dto/modules/app_color_module.dart';

class CountryWidget extends StatelessWidget {
  final DropDownBloc countryBloc;
  final List<DropDownMapper> countryList;

  const CountryWidget(
      {super.key, required this.countryBloc, required this.countryList});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) => CustomDropDownWidget(
              dropDownList: countryList,
              onSelect: (value) => countryBloc.updateValue(value),
              headerText: S.of(context).chooseYourCountry),
          backgroundColor: Colors.transparent,
          enableDrag: false,
        ),
        child: Container(
          height: 55.h,
          decoration: grayRectangleBorder,
          padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 13.w),
          child: StreamBuilder<DropDownMapper?>(
              stream: countryBloc.selectedDropDownStream,
              builder: (context, snapshot) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    snapshot.data != null
                        ? ImageHelper(
                            image: snapshot.data?.image ?? '',
                            imageType: ImageType.network,
                            width: 39.w,
                            height: 26.h,
                            boxFit: BoxFit.fill,
                          )
                        : Container(),
                    SizedBox(width: 8.w,),
                    ImageHelper(
                      image: 'assets/svg/ic_arrow_down.svg',
                      imageType: ImageType.svg,
                      width: 17.w,
                      height: 9.h,
                      color: secondaryColor,
                    ),
                  ],
                )),
        ),
      );
}
