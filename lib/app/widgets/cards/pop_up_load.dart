import 'package:flutter/material.dart';

import '../../style/app_color.dart';

class PopUpLoad extends StatelessWidget {
  const PopUpLoad({
    super.key,
    required this.children,
    this.onTap,
    this.alignment = CrossAxisAlignment.start,
    this.padding,
  });

  final List<Widget> children;
  final Function(String)? onTap;
  final CrossAxisAlignment alignment;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Material(
          color: AppColor.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: alignment,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
