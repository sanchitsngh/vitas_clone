import 'package:flutter/material.dart';

import 'package:vitas_clone/core/constants/app_colors.dart';

enum VitasCardElevation { low, high }

const BoxShadow shadowLowElevation = BoxShadow(
    color: shadowColorLowElevation, offset: Offset.zero, blurRadius: 4.0);
const BoxShadow shadowHighElevation = BoxShadow(
    color: shadowColorHighElevation, offset: Offset.zero, blurRadius: 6.0);
const Radius cardRadius = Radius.circular(8.0);

class VitasCard extends StatelessWidget {
  final Widget child;
  final Radius radius;
  final Color color;
  final BoxShadow shadow;
  final VoidCallback? onTap;

  VitasCard({
    super.key, 
    elevation = VitasCardElevation.low,
    this.radius = cardRadius,
    this.color = Colors.white,
    required Widget child,
    this.onTap,
  })  : child = (onTap == null)
            ? child
            : Material(
                color: color,
                borderRadius: BorderRadius.all(radius),
                child: InkWell(
                  borderRadius: BorderRadius.all(radius),
                  onTap: onTap,
                  child: child,
                ),
              ),
        shadow = (elevation == VitasCardElevation.low)
            ? const BoxShadow(
                color: shadowColorLowElevation,
                offset: Offset.zero,
                blurRadius: 4.0)
            : const BoxShadow(
                color: shadowColorHighElevation,
                offset: Offset.zero,
                blurRadius: 6.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(radius),
        boxShadow: [shadow],
      ),
      child: child,
    );
  }
}
