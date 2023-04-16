import 'dart:convert';

import 'package:get/get.dart';
import '../model/venue_slots_model.dart';
import '../utils/remote_services.dart';

class VenueSlotsController extends GetxController {
  bool loading = false;

  final int venueId;

  @override
  void onInit() {
    super.onInit();
    loadVenueSlots();
  }

  VenueSlotsController(this.venueId);
  List<VenueSlotsModel> slots = <VenueSlotsModel>[];
  loadVenueSlots() async {
    loading = true;
    update();
    var response = await RemoteServices().fetchVenueSlots(venueId);
    slots = venueSlotsModelFromJson(
      json.encode(
        response.data['data'],
      ),
    );
    loading = false;
    update();
    loadBookedvenueSlots();
  }

  List<BookedVenueSlots> booked = [];
  loadBookedvenueSlots() async {
    String date =
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    var response = await RemoteServices().fetchBookedVenueSlots(venueId, date);
    booked = bookedVenueSlotsFromJson(
      json.encode(
        response.data['data'],
      ),
    );
    update();
  }

  VenueSlotsModel? selectedSlot;

  selectSlot(VenueSlotsModel model) {
    if (selectedSlot?.id == model.id) {
      selectedSlot = null;
    } else {
      selectedSlot = model;
    }
    quantity = 1;
    update();
  }

  DateTime selectedDate = DateTime.now();
  changeDate(DateTime date) {
    selectedDate = date;
    selectedSlot = null;
    quantity = 1;
    update();
    loadBookedvenueSlots();
  }

  isSelected(DateTime date) {
    if (date.year == selectedDate.year &&
        date.month == selectedDate.month &&
        date.day == selectedDate.day) {
      return true;
    } else {
      return false;
    }
  }

  bool isAlreadyBooked(VenueSlotsModel model) {
    if (booked.any((element) => element.slotId == model.id)) {
      return (booked
              .firstWhere((element) => element.slotId >= model.id)
              .booked) >=
          model.capacity;
    } else {
      return false;
    }
  }

  int getBooked(VenueSlotsModel model) {
    if (booked.any((element) => element.slotId == model.id)) {
      return model.capacity -
          booked.firstWhere((element) => element.slotId == model.id).booked;
    } else {
      return 0;
    }
  }

  int quantity = 1;
  increaseQuantity() {
    int remaining = getBooked(selectedSlot!);
    if (remaining + quantity < (selectedSlot!.capacity)) {
      quantity++;
      update();
    }
  }

  decreaseQuantity() {
    if (quantity <= 1) {
    } else {
      quantity--;
      update();
    }
  }
}

List<BookedVenueSlots> bookedVenueSlotsFromJson(String str) =>
    List<BookedVenueSlots>.from(
        json.decode(str).map((x) => BookedVenueSlots.fromJson(x)));

class BookedVenueSlots {
  BookedVenueSlots({
    required this.slotId,
    required this.booked,
  });

  int slotId;
  int booked;

  factory BookedVenueSlots.fromJson(Map<String, dynamic> json) =>
      BookedVenueSlots(
        slotId: json["slot_id"],
        booked: int.parse(json['booked'].toString()),
      );
}
