import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/strings.dart';
import 'package:my_portfolio/provider/theme.dart';
import 'package:my_portfolio/core/utils/constants.dart';
import 'package:my_portfolio/core/utils/screen_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../models/technology.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache taake web par background loading delay bilkul khatam ho jaye
    precacheImage(const AssetImage(AppConstants.myTutorImage), context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: _buildUi(kDesktopMaxWidth),
      tablet: _buildUi(kTabletMaxWidth),
      mobile: _buildUi(getMobileMaxWidth(context)),
    );
  }

  Widget _buildUi(double width) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 720;

          return ResponsiveWrapper(
            maxWidth: width,
            minWidth: width,
            defaultScale: false,
            child: Flex(
              direction: isLargeScreen ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// LEFT SIDE (TEXT CONTENT)
                Expanded(
                  flex: isLargeScreen ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "About Me",
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.w900,
                          fontSize: 34,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        Strings.titleDescription,
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        Strings.aboutMeDescription,
                        style: const TextStyle(
                          color: kCaptionColor,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        "Technologies I Work With",
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.w800,
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      /// TECH SCROLL
                      Consumer(
                        builder: (context, ref, _) {
                          final isDark = ref.watch(themeProvider).isDarkMode;

                          return SizedBox(
                            height: 45,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  TechnologyConstants.technologyLearned.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                final e = TechnologyConstants
                                    .technologyLearned[index];

                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.06)
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.05)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(e.logo,
                                          width: 18, height: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        e.name,
                                        style: const TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),

                const SizedBox(width: 25, height: 25),

                /// RIGHT SIDE (IMAGE) - Mobile pr b center me show hogi fuzool gayab nhi hogi
                Expanded(
                  flex: isLargeScreen ? 1 : 0,
                  child: Center(
                    child: Container(
                      width: isLargeScreen ? 280 : 220,
                      height: isLargeScreen ? 280 : 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppConstants.myTutorImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
