import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';
import 'package:sopefoodrestaurantes/models/api_error.dart';
import 'package:sopefoodrestaurantes/models/environment.dart';
import 'package:sopefoodrestaurantes/models/ready_orders.dart';
import 'package:sopefoodrestaurantes/views/home/home_page.dart';
import 'package:sopefoodrestaurantes/views/order/active_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  final box = GetStorage();
  ReadyOrders? order;

  int tabIndex = 0;

  double _tripDistance = 0;

  // Getter
  double get tripDistance => _tripDistance;

  // Setter
  set setDistance(double newValue) {
    _tripDistance = newValue;
  }

  // Reactive state
  var _count = 0.obs;

  // Getter
  int get count => _count.value;

  // Setter
  set setCount(int newValue) {
    _count.value = newValue;
  }

  var _setLoading = false.obs;

  // Getter
  bool get setLoading => _setLoading.value;

  // Setter
  set setLoading(bool newValue) {
    _setLoading.value = newValue;
  }

  void pickOrder(String orderId) async {
    String token = box.read('token');
    String driverId = box.read('driverId');
    String accessToken = jsonDecode(token);

    setLoading = true;
    var url = Uri.parse(
        '${Environment.appBaseUrl}/api/orders/picked-orders/$orderId/$driverId');

    try {
      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        setLoading = false;

        Get.snackbar("Pedido recogido con éxito",
            "Para ver el Pedido, vaya a la pestaña activa",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(FontAwesome5Solid.shipping_fast));

        Map<String, dynamic> data = jsonDecode(response.body);
        order = ReadyOrders.fromJson(data);

        Get.off(() => const ActivePage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else {
        var data = apiErrorFromJson(response.body);

        Get.snackbar(data.message,
            "No se pudo seleccionar un pedido, Inténtelo nuevamente",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      setLoading = false;

      Get.snackbar(e.toString(),
          "No se pudo seleccionar un pedido, Inténtelo nuevamente",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error));
    } finally {
      setLoading = false;
    }
  }

  void processOrder(String orderId, String status) async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);

    setLoading = true;
    var url = Uri.parse(
        '${Environment.appBaseUrl}/api/orders/process/$orderId/$status');
    try {
      var response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        setLoading = false;

        Get.off(() => const HomePage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else {
        var data = apiErrorFromJson(response.body);

        Get.snackbar(data.message,
            "No se pudo marcar como entregado. Inténtelo de nuevo o comuníquese con el soporte.",
            colorText: kLightWhite,
            backgroundColor: kRed,
            icon: const Icon(Icons.error));
      }
    } catch (e) {
      setLoading = false;

      Get.snackbar(e.toString(),
          "No se pudo marcar el pedido como entregado. Inténtelo de nuevo.",
          colorText: kLightWhite,
          backgroundColor: kRed,
          icon: const Icon(Icons.error));
    } finally {
      setLoading = false;
    }
  }
}
