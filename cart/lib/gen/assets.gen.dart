/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/empty_cart.png
  AssetGenImage get emptyCart =>
      const AssetGenImage('assets/png/empty_cart.png');

  /// List of all assets
  List<AssetGenImage> get values => [emptyCart];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/cart_success.svg
  String get cartSuccess => 'packages/cart/assets/svg/cart_success.svg';

  /// File path: assets/svg/cart_success_logo.svg
  String get cartSuccessLogo =>
      'packages/cart/assets/svg/cart_success_logo.svg';

  /// File path: assets/svg/empty_cart.svg
  String get emptyCart => 'packages/cart/assets/svg/empty_cart.svg';

  /// File path: assets/svg/ic_cash.svg
  String get icCash => 'packages/cart/assets/svg/ic_cash.svg';

  /// File path: assets/svg/ic_date.svg
  String get icDate => 'packages/cart/assets/svg/ic_date.svg';

  /// File path: assets/svg/ic_items.svg
  String get icItems => 'packages/cart/assets/svg/ic_items.svg';

  /// File path: assets/svg/ic_location.svg
  String get icLocation => 'packages/cart/assets/svg/ic_location.svg';

  /// File path: assets/svg/ic_time.svg
  String get icTime => 'packages/cart/assets/svg/ic_time.svg';

  /// File path: assets/svg/ic_total.svg
  String get icTotal => 'packages/cart/assets/svg/ic_total.svg';

  /// File path: assets/svg/ic_wallet.svg
  String get icWallet => 'packages/cart/assets/svg/ic_wallet.svg';

  /// List of all assets
  List<String> get values => [
        cartSuccess,
        cartSuccessLogo,
        emptyCart,
        icCash,
        icDate,
        icItems,
        icLocation,
        icTime,
        icTotal,
        icWallet
      ];
}

class Assets {
  Assets._();

  static const String package = 'cart';

  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  static const String package = 'cart';

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/cart/$_assetName';
}
