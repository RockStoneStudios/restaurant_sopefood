import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';
import 'package:sopefoodrestaurantes/models/api_error.dart';
import 'package:sopefoodrestaurantes/models/environment.dart';
import 'package:sopefoodrestaurantes/models/restaurant_response.dart';
import 'package:sopefoodrestaurantes/models/status.dart';
import 'package:sopefoodrestaurantes/models/sucess_model.dart';
import 'package:sopefoodrestaurantes/views/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RestaurantController extends GetxController {
  final box = GetStorage();
  RestaurantResponse? restaurant;

  RxBool _isAvailable = false.obs;

  bool get isAvailable => _isAvailable.value;

  set setAvailability(bool newValue) {
    _isAvailable.value = newValue;
  }

  RxBool _status = false.obs;

  bool get status => _status.value;

  set setStatus(bool newValue) {
    _status.value = newValue;
    refetch.value = newValue;
  }

  var refetch = false.obs;

  // Function to be called when status changes
  Function? onStatusChange;

  @override
  void onInit() {
    super.onInit();
    // Set up the listener
    ever(refetch, (_) async {
      if (refetch.isTrue && onStatusChange != null) {
        await Future.delayed(const Duration(seconds: 5));
        onStatusChange!();
      }
    });
  }

  void setOnStatusChangeCallback(Function callback) {
    onStatusChange = callback;
  }

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  void restaurantRegistration(String model) async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);
    setLoading = true;
    var url = Uri.parse('${Environment.appBaseUrl}/api/restaurant');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: model,
      );

      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);
        setLoading = false;
        Get.snackbar(data.message,
            "Gracias por registrarte, espera la aprobación. Te avisaremos pronto por correo electrónico.",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(Icons.add_alert));

        Get.offAll(() => const Login(),
            transition: Transition.fade, duration: const Duration(seconds: 2));
      } else {
        var data = apiErrorFromJson(response.body);
        Get.snackbar(data.message, "Fallo al Loguearse, Intente Nuevamente",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      setLoading = false;
      Get.snackbar(e.toString(), "Fallo al Loguearse, Intente Nuevamente",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error));
    } finally {
      setLoading = false;
    }
  }

  void restaurantStatus() async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);
    String restaurantId = box.read('restaurantId');
    setLoading = true;
    var url =
        Uri.parse('${Environment.appBaseUrl}/api/restaurant/$restaurantId');
    try {
      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        Status data = statusFromJson(response.body);
        box.write("status", data.isAvailable);
        setStatus = data.isAvailable;
      } else {
        var data = apiErrorFromJson(response.body);
        Get.snackbar(data.message, "Fallo al Loguearse, Intente Nuevamente",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
