import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../core/services/booking_service.dart';

final bookingProvider = ChangeNotifierProvider<BookingProvider>(
  (ref) => BookingProvider(),
);

class BookingProvider extends ChangeNotifier {
  bool isLoading = false;

  String sessionType = "Scheduled Slot";

  String purpose = "📚 Tutoring";

  String? selectedSlot;

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final countryController = TextEditingController();

  final commentController = TextEditingController();

  void setPurpose(String value) {
    purpose = value;
    notifyListeners();
  }

  void setSessionType(String value) {
    sessionType = value;
    notifyListeners();
  }

  void setSlot(String value) {
    selectedSlot = value;
    notifyListeners();
  }

  Future<void> submitBooking() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await BookingService.submit({
        "name": nameController.text,
        "email": emailController.text,
        "country": countryController.text,
        "purpose": purpose,
        "sessionType": sessionType,
        "slot": selectedSlot ?? "",
        "comment": commentController.text,
      });

      debugPrint(result.toString());
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    countryController.clear();
    commentController.clear();

    selectedSlot = null;
    purpose = "📚 Tutoring";
    sessionType = "Scheduled Slot";

    notifyListeners();
  }

  String? validate() {
    if (nameController.text.trim().isEmpty) {
      return "Please enter your name";
    }

    if (emailController.text.trim().isEmpty) {
      return "Please enter your email";
    }

    final email = emailController.text.trim();

    if (!RegExp(
      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
    ).hasMatch(email)) {
      return "Please enter a valid email";
    }

    if (countryController.text.trim().isEmpty) {
      return "Please select your country";
    }

    if (sessionType == "Scheduled Slot" && selectedSlot == null) {
      return "Please select a slot";
    }

    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    countryController.dispose();
    commentController.dispose();
    super.dispose();
  }
}
