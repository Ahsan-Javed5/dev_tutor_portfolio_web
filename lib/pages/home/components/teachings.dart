import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/constants.dart';
import 'package:my_portfolio/core/utils/screen_helper.dart';
import 'package:my_portfolio/provider/theme.dart';
import 'package:my_portfolio/models/teachings_model.dart';

class TeachingSection extends StatelessWidget {
  final List<TeachingModel> teachings;

  const TeachingSection({Key? key, required this.teachings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: _buildUi(kDesktopMaxWidth, context),
      tablet: _buildUi(kTabletMaxWidth, context),
      mobile: _buildUi(getMobileMaxWidth(context), context),
    );
  }

  Widget _buildUi(double width, BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SizedBox(
        height: 420, // important: prevents layout overflow & improves UX
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: teachings.length,
          itemBuilder: (context, index) {
            final e = teachings[index];

            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildProject(width, e),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProject(double width, TeachingModel teachingModel) {
    return Consumer(
      builder: (context, ref, _) {
        final isDark = ref.watch(themeProvider).isDarkMode;

        return Container(
          width: ScreenHelper.isMobile(context) ? width * 0.9 : width * 0.45,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark
                ? const Color.fromARGB(60, 20, 20, 20)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                teachingModel.title,
                style: GoogleFonts.josefinSans(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 12),

              /// DESCRIPTION LIST (FIXED UX)
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 160),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: teachingModel.descriptionList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "• ",
                            style: TextStyle(color: kCaptionColor),
                          ),
                          Expanded(
                            child: Text(
                              teachingModel.descriptionList[index],
                              style: const TextStyle(
                                color: kCaptionColor,
                                fontSize: 14.5,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// subtle hint (optional UX improvement)
              const SizedBox(height: 6),
              Text(
                "Swipe horizontally →",
                style: TextStyle(
                  fontSize: 12,
                  color: kCaptionColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
