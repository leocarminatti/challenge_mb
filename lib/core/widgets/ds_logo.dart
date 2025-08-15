import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DsLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const DsLogo({
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SvgPicture.asset(
      'assets/images/coinmarketcap.svg',
      width: width,
      height: height,
      fit: fit,
      colorFilter: ColorFilter.mode(
        color ?? theme.colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }
}
