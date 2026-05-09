import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    this.iconData,
    this.onTap,
    this.radius = 0,
  });

  final double radius;
  final IconData? iconData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Icon(iconData),
          onTap: onTap,
        ),
      ),
    );
  }
}
