import 'package:flutter/material.dart';
import '../values/app_sizes.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppSizes.breakpointMobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppSizes.breakpointMobile &&
      MediaQuery.sizeOf(context).width < AppSizes.breakpointTablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppSizes.breakpointTablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppSizes.breakpointTablet) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= AppSizes.breakpointMobile) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
