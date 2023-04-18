import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'session.dart';

class RemoteServices {
  final String baseip = "http://172.16.17.3/sportyways/";
  final String api = "http://172.16.17.3/sportyways/api/";
  final String media = "http://172.16.17.3/sportyways/media/";
  Dio dio = Dio();
  Future<Dio> getDio() async {
    String userid = (await Session().readId()).toString();

    dio.options
      ..validateStatus = (int? status) {
        return true;
      }
      ..receiveDataWhenStatusError = true
      ..headers = {
        'authorization': userid,
      };
    return dio;
  }

  Future<Response> login(String email, String password) async {
    String url = "${api}auth/login.php";
    FormData data = FormData.fromMap({
      "email": email,
      "password": password,
    });
    var response = await Dio().post(url, data: data);
    return response;
  }

  Future<Response> signup({
    required String email,
    required String username,
    required String fullName,
    required String gender,
    required String mobileNumber,
    required String password,
  }) async {
    String url = "${api}auth/signup_customer.php";
    FormData data = FormData.fromMap({
      "username": username,
      "email": email,
      "password": password,
      "phone_no": mobileNumber,
      "gender": gender,
      "full_name": fullName,
    });
    log(data.fields.toString());
    var response = await Dio().post(url, data: data);
    log(response.data.toString());
    return response;
  }

  Future<Response> readProfile() async {
    var dio = await getDio();
    String url = "${api}auth/profile.php";
    var response = await dio.get(url);
    return response;
  }

  Future<Response> updateProfile(
    String fullName,
    String email,
    String phone,
    String gender,
    File? image,
  ) async {
    String url = "${api}auth/update_profile.php";

    FormData formData = FormData.fromMap(
      {
        "full_name": fullName,
        "email": email,
        "phone_no": phone,
        "gender": gender,
      },
    );
    if (image != null) {
      formData.files.add(
        MapEntry(
          "profile_picture",
          await MultipartFile.fromFile(
            image.path,
          ),
        ),
      );
    } else {}
    var response = await (await getDio()).post(
      url,
      data: formData,
      options: Options(
        receiveDataWhenStatusError: true,
        validateStatus: (val) => true,
      ),
    );
    return response;
  }

  Future<Response> changePassword(
    String email,
    String currentPassword,
    String newPassword,
  ) async {
    var dio = await getDio();
    String url = "${api}auth/change_password.php";
    var response = await Dio().post(
      url,
      data: FormData.fromMap(
        {
          "email": email,
          "password": currentPassword,
          "newpassword": newPassword,
        },
      ),
    );
    return response;
  }

  Future<Response> fetchBanners() async {
    String url = "${api}banners/";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> fetchCategories() async {
    String url = "${api}categories/";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> fetchCities() async {
    String url = "${api}cities/";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> fetchVenues() async {
    String url = "${api}venues/";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> queryVenues(String query, String value) async {
    String url = "${api}venues?$query=$value";
    log(url);
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> searchVenues(String query) async {
    String url = "${api}venues?query=$query";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> fetchVenuesByid(int id) async {
    String url = "${api}venues?id=$id";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> fetchVenuesAmenities(int id) async {
    String url = "${api}amenities?venue=$id";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> fetchFeedbacks(int id) async {
    String url = "${api}feedbacks/?venue=$id";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> postFeedback({
    required int venueId,
    required double rating,
    required String review,
  }) async {
    String url = "${api}feedbacks/post.php";
    var dio = await getDio();
    FormData data = FormData.fromMap({
      "venue_id": venueId,
      "rating": rating,
      "review": review,
    });
    var response = await dio.post(url, data: data);
    return response;
  }

  Future<Response> fetchVenueSlots(int id) async {
    String url = "${api}slots/?venue=$id";
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> fetchBookedVenueSlots(int id, String date) async {
    String url = "${api}slots/booked_slots.php?venue=$id&date=$date";
    log(url);
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> checkout(Map<String, dynamic> map) async {
    Dio dio = await getDio();
    String url = "${api}checkout/";
    FormData data = FormData.fromMap(map);
    var response = await dio.post(url, data: data);
    return response;
  }

  Future<Response> myBookings() async {
    Dio dio = await getDio();
    String url = "${api}my_bookings/";
    var response = await dio.get(url);
    return response;
  }

  Future<Response> myFavs() async {
    Dio dio = await getDio();
    String url = "${api}my_favs/";
    var response = await dio.get(url);
    return response;
  }

  Future<Response> isFav(int id) async {
    Dio dio = await getDio();
    String url = "${api}venues/is_fav.php?venue_id=$id";
    var response = await dio.get(url);
    return response;
  }

  Future<Response> addToFav(int id) async {
    Dio dio = await getDio();
    String url = "${api}venues/fav.php?venue_id=$id";

    var response = await dio.get(url);
    return response;
  }

  Future<Response> requestReset(String email) async {
    String url = "${api}auth/passwordreset/requestreset.php?email=$email";
    log(url.toString());
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> verifyCode(String email, String token) async {
    String url =
        "${api}auth/passwordreset/verifyCode.php?email=$email&token=$token";
    log(url);
    var response = await Dio().get(url);
    return response;
  }

  Future<Response> resetPassword(String token, String password) async {
    String url = "${api}auth/passwordreset/resetpassword.php";
    FormData data = FormData.fromMap({
      "token": token,
      "password": password,
    });
    var response = await Dio().post(url, data: data);
    return response;
  }
}
