import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/core/utils/constants.dart';
import 'package:my_portfolio/pages/home/home.dart';
import 'package:my_portfolio/pages/home/smart_bill_book/smart_bill_book.dart';
import 'package:my_portfolio/pages/works/works.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Routes {
  static const String initial = "/";
  static const String demos = "demos";
  static const String myWorks = "works";
  static const String simulation = "simulation";
  static const String sandSimulation = "simulation/sand";
  static const String jsonToDart = "json_to_dart";
  static const String videoDownloader = "video_downloader";
  static const String smartBillBookPrivacy = "smart_bill_book/privacy";
}

class RouterGenerator {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.initial,
        builder: (context, state) => const _AppResponsiveBuilder(
          child: Home(),
        ),
        routes: [
          GoRoute(
            path: Routes.myWorks,
            name: Routes.myWorks,
            builder: (context, state) =>
                const _AppResponsiveBuilder(child: MyWorksScreen()),
          ),
          GoRoute(
            path: Routes.smartBillBookPrivacy,
            name: Routes.smartBillBookPrivacy,
            builder: (context, state) => const _AppResponsiveBuilder(
                child: SmartBillBookPrivacyPolicyScreen()),
          ),
        ],
      ),
    ],
  );
}

class _AppResponsiveBuilder extends StatelessWidget {
  final Widget child;
  const _AppResponsiveBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper.builder(
      ClampingScrollWrapper.builder(context, child),
      defaultScale: true,
      breakpoints: [
        const ResponsiveBreakpoint.resize(450, name: MOBILE),
        const ResponsiveBreakpoint.resize(800, name: TABLET),
        const ResponsiveBreakpoint.resize(1000, name: TABLET),
        const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        const ResponsiveBreakpoint.resize(2460, name: "4K"),
      ],
      background: Container(
        color: kBackgroundColor,
      ),
    );
  }
}
