import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../deel.dart';

class MapPreviewWidget extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final double? width;
  final double? height;
  final bool showEditLocation;
  final VoidCallback clickOnChangeLocation;

  final Function(double latitude, double longitude)? onLocationDetection;

  const MapPreviewWidget({
    super.key,
    this.latitude,
    this.longitude,
    this.height,
    this.width,
    this.showEditLocation = true,
    required this.clickOnChangeLocation,
    this.onLocationDetection,
  });

  @override
  State<MapPreviewWidget> createState() => _MapPreviewWidgetState();
}

class _MapPreviewWidgetState extends State<MapPreviewWidget> {
  final MapPreviewBloc _bloc = MapPreviewBloc();
  final String _mapUrlTemplate =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  late final MapOptions _mapOptions = MapOptions(
    onMapReady: () {
      _bloc.mapReady(true);
    },
    interactionOptions: const InteractionOptions(flags: InteractiveFlag.none),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.initPermissionAndLocation(
        context,
        onLocationDetection: widget.onLocationDetection,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.latitude != null && widget.longitude != null) {
      _bloc.isLocationChanged = true;
      _bloc.latLng(widget.latitude ?? 0.0, widget.longitude ?? 0.0);
    }

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
          widget.showEditLocation ? _editLocationWidget : SizedBox(),
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
      ),
      _markerStreamBuilder,
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
        color: switchBorderColor,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: CustomText(
          text: Loc.of(context)!.editLocation,
          customTextStyle: BoldStyle(color: secondaryColor, fontSize: 16.w),
        ),
      ),
    ),
  );

  Widget get _markerStreamBuilder => StreamBuilder(
    stream: _bloc.latLngStream,
    builder: (context, snapshot) => snapshot.data == null
        ? Container()
        : MarkerLayer(
            markers: [
              Marker(
                alignment: Alignment.center,
                width: 50.w,
                height: 50.h,
                point: snapshot.data!,
                child: Icon(Icons.location_pin, color: redColor, size: 35.r),
              ),
            ],
          ),
    initialData: null,
  );
}
