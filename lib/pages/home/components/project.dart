import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/core/utils/constants.dart';
import 'package:my_portfolio/core/utils/screen_helper.dart';
import 'package:my_portfolio/core/utils/utils.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/provider/theme.dart';

class ProjectSection extends StatelessWidget {
  final List<ProjectModel> projects;

  const ProjectSection({Key? key, required this.projects}) : super(key: key);

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
        height: 520,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];

            return Container(
              width: width,
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildProject(width, project),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProject(double width, ProjectModel projectModel) {
    return Consumer(
      builder: (context, ref, _) {
        final isDark = ref.watch(themeProvider).isDarkMode;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark
                ? const Color.fromARGB(60, 20, 20, 20)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Flex(
                direction: ScreenHelper.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// IMAGE SECTION
                  if (projectModel.appPhotos != null)
                    SizedBox(
                      width: ScreenHelper.isMobile(context)
                          ? width * 0.9
                          : width * 0.45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          projectModel.appPhotos!,
                          height: 260,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  const SizedBox(width: 20, height: 20),

                  /// DETAILS SECTION
                  SizedBox(
                    width: ScreenHelper.isMobile(context)
                        ? width * 0.9
                        : width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projectModel.project,
                          style: GoogleFonts.josefinSans(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          projectModel.title,
                          style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// DESCRIPTION (FIXED)
                        Text(
                          projectModel.description,
                          style: const TextStyle(
                            color: kCaptionColor,
                            fontSize: 14.5,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// TECH SECTION
                        if (projectModel.techUsed.isNotEmpty) ...[
                          Text(
                            "Technologies Used",
                            style: GoogleFonts.josefinSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: projectModel.techUsed.map((e) {
                              return Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: e.logo == AppConstants.razorPayImage
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                                child: Image.asset(e.logo),
                              );
                            }).toList(),
                          ),
                        ],

                        const SizedBox(height: 22),

                        /// BUTTON
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 14,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (projectModel.internalLink) {
                                context.goNamed(projectModel.projectLink);
                              } else {
                                Utilty.openUrl(projectModel.projectLink);
                              }
                            },
                            child: Text(
                              (projectModel.buttonText ?? "Explore More")
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
