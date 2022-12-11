import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schedule_booking/common/styles.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.onTap, this.hasData = false});
  final VoidCallback? onTap;
  final bool hasData;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      icon: SvgPicture.asset(
        "ic_filter.svg".svgPath,
        color: hasData ? AppStyles.mainColor : null,
      ),
      onPressed: onTap,
    );
  }
}
