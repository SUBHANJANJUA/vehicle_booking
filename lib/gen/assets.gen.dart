/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/qr_scanner_lottie.json
  String get qrScannerLottie => 'assets/animations/qr_scanner_lottie.json';

  /// List of all assets
  List<String> get values => [qrScannerLottie];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/alto.png
  AssetGenImage get alto => const AssetGenImage('assets/image/alto.png');

  /// File path: assets/image/byke_icon.png
  AssetGenImage get bykeIcon =>
      const AssetGenImage('assets/image/byke_icon.png');

  /// File path: assets/image/car_icon.png
  AssetGenImage get carIcon => const AssetGenImage('assets/image/car_icon.png');

  /// File path: assets/image/cultus.png
  AssetGenImage get cultus => const AssetGenImage('assets/image/cultus.png');

  /// File path: assets/image/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/image/logo.png');

  /// File path: assets/image/profile_bg.png
  AssetGenImage get profileBg =>
      const AssetGenImage('assets/image/profile_bg.png');

  /// File path: assets/image/truck.png
  AssetGenImage get truck => const AssetGenImage('assets/image/truck.png');

  /// File path: assets/image/truck_icon.png
  AssetGenImage get truckIcon =>
      const AssetGenImage('assets/image/truck_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    alto,
    bykeIcon,
    carIcon,
    cultus,
    logo,
    profileBg,
    truck,
    truckIcon,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsImageGen image = $AssetsImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
