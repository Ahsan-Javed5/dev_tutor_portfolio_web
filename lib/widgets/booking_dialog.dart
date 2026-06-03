import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_portfolio/core/utils/constants.dart';

import '../provider/booking_provider.dart';
import 'booking_slots.dart';

class BookingDialog extends ConsumerWidget {
  const BookingDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(bookingProvider);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      child: Container(
        width: 520,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Book a Session",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      ref.read(bookingProvider).clearForm();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Reserve a mentoring or development session.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              _field(
                booking.nameController,
                "Full Name",
              ),
              const SizedBox(height: 12),
              _field(
                booking.emailController,
                "Email",
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (country) {
                      booking.countryController.text = country.name;
                      booking.notifyListeners();
                    },
                  );
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: booking.countryController,
                    decoration: const InputDecoration(
                      labelText: "Country",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Purpose",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _purposeChip(
                    ref,
                    booking,
                    "📚 Tutoring",
                  ),
                  _purposeChip(
                    ref,
                    booking,
                    "💻 Development",
                  ),
                  _purposeChip(
                    ref,
                    booking,
                    "🎯 Exam Prep",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Session Type",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _sessionChip(
                    ref,
                    booking,
                    "Scheduled Slot",
                  ),
                  _sessionChip(
                    ref,
                    booking,
                    "Quick Session Request",
                  ),
                  _sessionChip(
                    ref,
                    booking,
                    "Custom Time Request",
                  ),
                ],
              ),
              if (booking.sessionType == "Scheduled Slot") ...[
                const SizedBox(height: 22),
                OutlinedButton.icon(
                  style:
                      OutlinedButton.styleFrom(foregroundColor: kPrimaryColor),
                  onPressed: () async {
                    final slot = await _showSlotPicker(
                      context,
                    );

                    if (slot != null) {
                      ref.read(bookingProvider).setSlot(slot);
                    }
                  },
                  icon: const Icon(
                    Icons.schedule,
                    color: Colors.white,
                  ),
                  label: Text(
                    booking.selectedSlot == null
                        ? "Choose Slot"
                        : "Change Slot",
                    style: TextStyle(
                        //color: Colors.white,
                        ),
                  ),
                ),
                if (booking.selectedSlot != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Text(
                      booking.selectedSlot!,
                    ),
                  ),
                ],
              ],
              const SizedBox(height: 10),
              TextField(
                controller: booking.commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Comment (Optional)",
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: booking.isLoading
                      ? null
                      : () async {
                          final error = booking.validate();

                          if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error)),
                            );
                            return;
                          }
                          await ref
                              .read(
                                bookingProvider,
                              )
                              .submitBooking();

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Booking request submitted successfully.",
                                ),
                              ),
                            );

                            ref.read(bookingProvider).clearForm();
                            Navigator.pop(
                              context,
                            );
                          }
                        },
                  child: booking.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          "Submit Booking",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<String?> _showSlotPicker(
    BuildContext context,
  ) {
    final slots = BookingSlotsGenerator.generate();

    return showDialog<String>(
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select a Slot",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    itemCount: slots.length,
                    itemBuilder: (context, index) {
                      final slot = slots[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: ActionChip(
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormat("EEE, dd MMM").format(slot.start),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${DateFormat.jm().format(slot.start)} - ${DateFormat.jm().format(slot.end)} UAE",
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(
                              context,
                              slot.label,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _purposeChip(
    WidgetRef ref,
    BookingProvider booking,
    String value,
  ) {
    return ChoiceChip(
      label: Text(value),
      selected: booking.purpose == value,
      selectedColor: kPrimaryColor,
      onSelected: (_) {
        ref.read(bookingProvider).setPurpose(value);
      },
    );
  }

  Widget _sessionChip(
    WidgetRef ref,
    BookingProvider booking,
    String value,
  ) {
    return ChoiceChip(
      label: Text(value),
      selected: booking.sessionType == value,
      selectedColor: kPrimaryColor,
      onSelected: (_) {
        ref.read(bookingProvider).setSessionType(value);
      },
    );
  }

  Widget _field(
    TextEditingController c,
    String label,
  ) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        focusColor: Colors.orange,
      ),
    );
  }
}
