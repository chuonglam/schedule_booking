import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size,
  });
  final double? size;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/ic_logo.svg',
      width: size ?? 60,
    );
  }
}
