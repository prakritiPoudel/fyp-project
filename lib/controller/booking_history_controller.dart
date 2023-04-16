import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../model/booking_history_model.dart';
import '../utils/remote_services.dart';

class BookingHistoryController extends GetxController {
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  List<BookingHistoryModel> bookings = [];
  List<BookingHistoryModel> oldBookings = [];
  List<BookingHistoryModel> thisWeek = [];
  loadBookings() async {
    loading = true;
    update();
    var response = await RemoteServices().myBookings();
    bookings = bookingHistoryModelFromJson(json.encode(response.data['data']));
    filterOld();
    filterThisWeek();
    loading = false;
    update();
  }

  filterOld() {
    oldBookings.clear();
    DateTime date = DateTime.now();
    DateTime finalDate = DateTime(date.year, date.month, date.day);
    for (var item in bookings) {
      if (item.bookedDate.isBefore(finalDate)) {
        oldBookings.add(item);
      }
    }
    oldBookings.sort((a, b) => b.id.compareTo(a.id));
  }

  filterThisWeek() {
    thisWeek.clear();
    DateTime date = DateTime.now();
    DateTime finalDate = DateTime(date.year, date.month, date.day);
    for (var item in bookings) {
      log("${item.bookedDate} =====  $finalDate");
      if (item.bookedDate.compareTo(finalDate) >= 0) {
        thisWeek.add(item);
      }
    }
    thisWeek.sort((a, b) => b.id.compareTo(a.id));
  }
}
