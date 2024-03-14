import 'package:core/core.dart';
import 'package:core/dto/commonBloc/current_location_bloc.dart';
import 'package:core/dto/commonBloc/permission_bloc.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:core/ui/custom_progress_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/mapPreview/map_preview_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPreviewWidget extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final double? width;
  final double? height;
  final VoidCallback clickOnChangeLocation;

  const MapPreviewWidget(
      {super.key,
      this.latitude,
      this.longitude,
      this.height,
      this.width,
      required this.clickOnChangeLocation});

  @override
  State<MapPreviewWidget> createState() => _MapPreviewWidgetState();
}

class _MapPreviewWidgetState extends State<MapPreviewWidget> {
  final MapPreviewBloc _bloc = MapPreviewBloc();
  final String _mapUrlTemplate =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  final List<String> _mapSubDomains = ['a', 'b', 'c'];
  late final MapOptions _mapOptions = MapOptions(
      onMapReady: () {
        _bloc.mapReady(true);
      },
      interactionOptions:
          const InteractionOptions(flags: InteractiveFlag.none));

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if (widget.latitude != null && widget.longitude != null) {
      _bloc.isLocationChanged = true;
      _bloc.latLng(widget.latitude ?? 0.0, widget.longitude ?? 0.0);
    }
    _bloc.initPermissionAndLocation(context);
    return _blocProvider;
  }

  Widget get _blocProvider => BlocProvider(bloc: _bloc, child: _screenDesign);

  Widget get _screenDesign => _mapContainer;

  Widget get _mapContainer => SizedBox(
        height: widget.height ?? 200.h,
        width: widget.width ?? MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.w),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(child: _mapWidget),
              _editLocationWidget,
            ],
          ),
        ),
      );

  Widget get _mapWidget => FlutterMap(
        options: _mapOptions,
        mapController: _bloc.mapController,
        children: [
          TileLayer(
            urlTemplate: _mapUrlTemplate,
            // subdomains: _mapSubDomains,
          ),
          _markerStreamBuilder
        ],
      );

  Widget get _editLocationWidget => Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: InkWell(
        onTap: () => widget.clickOnChangeLocation(),
        child: Container(
          alignment: Alignment.center,
          color: primaryColor.withOpacity(0.6),
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: CustomText(
            text: S.of(context).editLocation,
            customTextStyle: RegularStyle(color: blackColor, fontSize: 16.w),
          ),
        ),
      ));

  Widget get _markerStreamBuilder => StreamBuilder(
        stream: _bloc.latLngStream,
        builder: (context, snapshot) => snapshot.data == null
            ? Container()
            : MarkerLayer(markers: [
                Marker(
                    alignment: Alignment.center,
                    width: 50.w,
                    height: 50.h,
                    point: snapshot.data!,
                    child: Icon(
                      Icons.location_pin,
                      color: redColor,
                      size: 35.r,
                    ))
              ]),
        initialData: null,
      );
}
