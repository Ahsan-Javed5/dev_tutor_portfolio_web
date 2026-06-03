class BookingModel {
  final String name;
  final String email;
  final String country;
  final String purpose;
  final String comment;
  final String sessionType;
  final String selectedSlot;

  BookingModel({
    required this.name,
    required this.email,
    required this.country,
    required this.purpose,
    required this.comment,
    required this.sessionType,
    required this.selectedSlot,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "country": country,
      "purpose": purpose,
      "comment": comment,
      "sessionType": sessionType,
      "selectedSlot": selectedSlot,
    };
  }
}
