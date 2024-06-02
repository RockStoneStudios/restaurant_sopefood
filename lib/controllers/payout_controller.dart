import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';
import 'package:sopefoodrestaurantes/models/environment.dart';
import 'package:sopefoodrestaurantes/models/sucess_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PayoutCotroller extends GetxController {
  final box = GetStorage();
  void payout(String data, Function? refetch) async {
    String token = box.read('token');
    String accessToken = jsonDecode(token);

    var url = Uri.parse('${Environment.appBaseUrl}/api/restaurant/payout');

    try {
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          },
          body: data);

      if (response.statusCode == 201) {
        var data = successResponseFromJson(response.body);
        refetch!();
        Get.snackbar(data.message,
            "Revise su correo electrónico para obtener actualizaciones sobre el progreso. ",
            colorText: kLightWhite,
            backgroundColor: kPrimary,
            icon: const Icon(SimpleLineIcons.bubbles));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
