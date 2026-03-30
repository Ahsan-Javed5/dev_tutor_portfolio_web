import 'package:my_portfolio/core/routes/routes.dart';
import 'package:my_portfolio/core/utils/constants.dart';
import 'package:my_portfolio/models/link.dart';
import 'package:my_portfolio/models/technology.dart';

class ProjectModel {
  final String project;
  final String title;
  final String description;
  final String? appPhotos;
  final String projectLink;
  final bool internalLink;
  final List<TechnologyModel> techUsed;
  List<LinkModel>? links = [];
  final String? buttonText;

  ProjectModel({
    required this.project,
    required this.title,
    required this.description,
    this.appPhotos,
    required this.projectLink,
    this.internalLink = false,
    required this.techUsed,
    this.buttonText,
    this.links,
  });

  static List<ProjectModel> projects = [
    ProjectModel(
      project: "Mobile Application",
      title: "American Taxi Dispatch",
      description:
          "American Taxi Dispatch is a seamless mobile solution for reliable transportation across the Chicagoland area. It features real-time vehicle tracking, secure Google Pay integration, and advanced booking options to provide users with a professional and efficient travel experience.",
      appPhotos: AppConstants.at_project_image,
      projectLink:
          "https://play.google.com/store/apps/details?id=com.ataxi.orders.ui",
      techUsed: [
        TechnologyConstants.flutter,
      ],
      buttonText: "Play Store",
    ),
    ProjectModel(
      project: "Mobile Application",
      title: "Feyst: Culinary Experiences",
      description:
          "Feyst is a premium food experience platform designed to connect foodies with unique dining encounters. It features personalized culinary matches, seamless event booking, and a curated selection of popular dishes to ensure every meal is a memorable exploration of flavors.",
      appPhotos: AppConstants.feyst_project_image,
      projectLink:
          "https://play.google.com/store/apps/details?id=com.feyst.foodies",
      techUsed: [
        TechnologyConstants.flutter,
      ],
      buttonText: "Play Store",
    ),
  ];

  static List<ProjectModel> demos = [
    ProjectModel(
      project: "Flutter App",
      title: "Flutter Web Portfolio",
      description: "",
      appPhotos: AppConstants.portfolioGif,
      projectLink: "https://github.com/AgnelSelvan/Flutter-Web-Portfolio",
      techUsed: [],
      buttonText: "Github Link",
    ),
  ];
}
