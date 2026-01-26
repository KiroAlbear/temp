import 'package:country_codes/country_codes.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../dto/commonBloc/drop_down_bloc.dart';
import '../dto/models/baseModules/drop_down_mapper.dart';
import '../dto/modules/app_color_module.dart';
import '../dto/modules/app_default_style.dart';
import '../dto/modules/odoo_dio_module.dart';
import '../generated/l10n.dart';
import 'custom_drop_down_widget.dart';

class CountryWidget extends StatefulWidget {
  final DropDownBloc countryBloc;

  final List<DropDownMapper> countryList;

  const CountryWidget(
      {super.key, required this.countryBloc, required this.countryList});

  @override
  State<CountryWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _setSelectToCountryCode(),
    );
  }

  void _setSelectToCountryCode() async {
    await CountryCodes.init();
    final CountryDetails details = CountryCodes.detailsForLocale();
    String pickedCountryId = details.dialCode ?? '';
    if (pickedCountryId.isNotEmpty && widget.countryList.isNotEmpty) {
      pickedCountryId = pickedCountryId.replaceAll('+', '');
      widget.countryBloc.updateValue(widget.countryList.firstWhere(
        (element) => element.description == pickedCountryId,
        orElse: () => widget.countryList.first,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => CustomDropDownWidget(
            dropDownList: widget.countryList,
            onSelect: (value) {
              // if(widget.newAccountBloc !=null){
              //   widget.newAccountBloc!.countryCodeBehaviour.sink.add("+${value.description}");
              // }
              widget.countryBloc.updateValue(value);
            },
            headerText: S.of(context).chooseYourCountry),
        backgroundColor: Colors.transparent,
        enableDrag: false,
      ),
      child: Container(
        height: 52.h,
        width: 90.w,
        decoration: grayRectangleBorder,
        padding: EdgeInsets.symmetric( horizontal: 0.w),
        child: StreamBuilder<DropDownMapper?>(
            stream: widget.countryBloc.selectedDropDownStream,
            builder: (context, snapshot) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    snapshot.data != null
                        ? ImageHelper(
                            image: OdooDioModule().baseUrl +
                                (snapshot.data?.image ?? ''),
                            imageType: ImageType.network,
                            width: 39.w,
                            height: 26.h,
                            boxFit: BoxFit.fill,
                          )
                        : Container(),
                    SizedBox(
                      width: 12.w,
                    ),
                    ImageHelper(
                      image: Assets.svg.icArrowDownGrey,
                      imageType: ImageType.svg,
                      // width: 15.w,
                      // height: 9.h,
                      color: greyTextFieldBorderColorLightMode,
                    ),
                  ],
                )),
      ),
    );
  }
}
