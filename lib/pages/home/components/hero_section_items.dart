import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/constants.dart';
import 'package:my_portfolio/core/utils/strings.dart';
import 'package:my_portfolio/provider/theme.dart';
import 'dart:html' as html;

import '../../../widgets/booking_dialog.dart';

class HeroSectionModel {
  final Widget text;
  final Widget image;

  HeroSectionModel({required this.text, required this.image});
}

HeroSectionModel getHeroSectionContent(
    double containerHeight, BuildContext context) {
  return HeroSectionModel(
    text: SizedBox(
      height: containerHeight,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Strings.fullTitle,
                  style: GoogleFonts.josefinSans(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 18.0),
                Text(
                  Strings.myName,
                  style: GoogleFonts.josefinSans(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                    letterSpacing: 2.3,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Row(
                  children: [
                    Icon(Icons.laptop, color: kCaptionColor, size: 14),
                    SizedBox(width: 5),
                    Text(
                      "Flutter Developer",
                      style: TextStyle(
                          color: kCaptionColor, fontSize: 15.0, height: 1.0),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.location_on, color: kCaptionColor, size: 14),
                    SizedBox(width: 2),
                    Text(
                      "Dubai, UAE",
                      style: TextStyle(
                          color: kCaptionColor, fontSize: 15.0, height: 1.0),
                    )
                  ],
                ),
                const SizedBox(height: 25.0),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  height: 48.0,
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const BookingDialog(),
                      );
                    },
                    child: Text(
                      "Book a Session",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  height: 48.0,
                  padding: const EdgeInsets.symmetric(horizontal: 33.0),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              'Choose Resume',
                              style: TextStyle(color: Colors.black),
                            ),
                            content: const Text(
                              'Which resume would you like to download?',
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  html.AnchorElement(
                                    href: 'assets/Ahsan-Javed-Tutor.pdf',
                                  )
                                    ..setAttribute(
                                      'download',
                                      'Ahsan_Javed_Tutor_CV.pdf',
                                    )
                                    ..click();
                                },
                                child: const Text(
                                  'Tutor CV',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  html.AnchorElement(
                                    href: 'assets/Ahsan-Javed-Dev.pdf',
                                  )
                                    ..setAttribute(
                                      'download',
                                      'Ahsan_Javed_Software_Engineer_CV.pdf',
                                    )
                                    ..click();
                                },
                                child: const Text(
                                  'Software Engineer CV',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Download CV",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                height: 70,
                child: Consumer(builder: (context, ref, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: AppConstants.socialLoginDatas
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                onTap: e.onTap,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  margin: const EdgeInsets.all(5),
                                  child: Center(
                                    child: FaIcon(
                                      e.iconData,
                                      color: ref.watch(themeProvider).isDarkMode
                                          ? MyThemes.lightTheme
                                              .scaffoldBackgroundColor
                                          : MyThemes
                                              .darkTheme.scaffoldBackgroundColor
                                              .withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    ),
    image: LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth > 720 ? 500 : 300;
        return SizedBox(
          width: size,
          height: size,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: CircleAvatar(
              radius: size / 2 - 1,
              backgroundImage: AssetImage(AppConstants.myImage),
            ),
          ),
        );
      },
    ),
  );
}
