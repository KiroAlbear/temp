import 'package:deel/deel.dart';
import 'package:flutter/material.dart';

class EditLocationPage extends BaseStatefulWidget {
  final NewAccountBloc newAccountBloc;
  const EditLocationPage({super.key, required this.newAccountBloc});

  @override
  State<EditLocationPage> createState() => _EditLocationPageState();
}

class _EditLocationPageState extends BaseState<EditLocationPage> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => false;

  @override
  bool get useCustomScaffold => false;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Widget getBody(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: MapModule().loadMap(
        onPicked: (latitude, longitude, city, area, address) {
          _confirmPickLocation(longitude, latitude, city, area, address);
        },
        latitude: widget.newAccountBloc.latitude,
        longitude: widget.newAccountBloc.longitude,
        hintText: Loc.of(context)!.locationYourLocation,
        buttonText: Loc.of(context)!.confirmLocation,
      ),
    ),
  );

  void _confirmPickLocation(
    double longitude,
    double latitude,
    String city,
    String area,
    String address,
  ) async {
    widget.newAccountBloc.longitude = longitude;
    widget.newAccountBloc.latitude = latitude;

    widget.newAccountBloc.streetNameBloc.textFormFiledBehaviour.sink.add(
      TextEditingController(text: address),
    );
    widget.newAccountBloc.streetNameBloc.updateStringBehaviour(address);
    widget.newAccountBloc.nextStep(NewAccountStepEnum.locationInfo);
    for (var element in widget.newAccountBloc.stateList) {
      if (element.name.toLowerCase().contains(city.toLowerCase())) {
        widget.newAccountBloc.cityBloc.textFormFiledBehaviour.sink.add(
          TextEditingController(text: element.name),
        );
        widget.newAccountBloc.cityBloc.updateStringBehaviour(element.name);
        widget.newAccountBloc.selectedState = element;
        break;
      }
    }

    await widget.newAccountBloc.pickLocationInfo();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pop(context);
    });
  }
}
