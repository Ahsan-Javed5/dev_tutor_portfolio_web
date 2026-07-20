import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/models/name_color.dart';
import 'package:my_portfolio/provider/theme.dart';
import 'package:my_portfolio/core/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:html' as html;
import '../../../models/design_process.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/screen_helper.dart';

final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "Learn",
    imagePath: "assets/images/learn.png",
    subtitle: "",
  ),
  DesignProcess(
    title: "Develop",
    imagePath: "assets/images/develop.png",
    subtitle: "",
  ),
  DesignProcess(
    title: "Teach",
    imagePath: "assets/images/teach.png",
    subtitle: "",
  ),
];

class ServiceSection extends StatelessWidget {
  ServiceSection({Key? key}) : super(key: key);

  final whatIDo = [
    NameIconColor(
      title: "Mobile App Development",
      iconData: Icons.mobile_friendly,
      color: Colors.greenAccent,
    ),
    NameIconColor(
      title: "Flutter Web Apps",
      iconData: Icons.web,
      color: Colors.amber,
    ),
    NameIconColor(
      title: "Mathematics Tutor",
      iconData: Icons.school,
      color: Colors.blueAccent,
    ),
    NameIconColor(
      title: "CS Tutor",
      iconData: Icons.computer,
      color: Colors.deepPurpleAccent,
    ),
    NameIconColor(
      title: "Open Source",
      iconData: Icons.code,
      color: Colors.orangeAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ScreenHelper(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Experienced & Productive",
                style: GoogleFonts.josefinSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {
                  html.AnchorElement(href: "assets/my_cv.pdf")
                    ..setAttribute("download", "Ahsan_Javed_CV.pdf")
                    ..click();
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "DOWNLOAD CV",
                    style: GoogleFonts.josefinSans(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            "What I Do",
            style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            "Building apps, teaching, and solving real-world problems",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 13.5,
            ),
          ),

          const SizedBox(height: 30),

          /// SERVICES (COMPACT WRAP)
          Consumer(
            builder: (context, ref, _) {
              final isDark = ref.watch(themeProvider).isDarkMode;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: whatIDo.map((e) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(e.iconData, color: e.color, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          e.title,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 35),

          /// DESIGN PROCESS (SIMPLIFIED)
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 20,
                runSpacing: 15,
                children: designProcesses.map((e) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(e.imagePath, width: 28),
                        const SizedBox(width: 10),
                        Text(
                          e.title,
                          style: GoogleFonts.josefinSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
