import 'package:intl/intl.dart';

class BookingSlot {
  final String label;
  final DateTime start;
  final DateTime end;

  BookingSlot({
    required this.label,
    required this.start,
    required this.end,
  });
}

class BookingSlotsGenerator {
  static List<BookingSlot> generate() {
    final List<BookingSlot> slots = [];

    final now = DateTime.now();

    for (int day = 0; day < 3; day++) {
      final currentDay = DateTime(
        now.year,
        now.month,
        now.day + day,
      );

      final morningSlots = [
        [8, 0],
        [8, 20],
        [8, 40],
      ];

      final nightSlots = [
        [21, 0],
        [21, 20],
        [21, 40],
      ];

      for (final slot in [...morningSlots, ...nightSlots]) {
        final start = DateTime(
          currentDay.year,
          currentDay.month,
          currentDay.day,
          slot[0],
          slot[1],
        );

        final end = start.add(
          const Duration(minutes: 20),
        );

        final date = DateFormat("EEE, dd MMM").format(start);

        final time =
            "${DateFormat.jm().format(start)} - ${DateFormat.jm().format(end)}";

        slots.add(
          BookingSlot(
            label: "$date\n$time (UAE)",
            start: start,
            end: end,
          ),
        );
      }
    }

    return slots;
  }
}
