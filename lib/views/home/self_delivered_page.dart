import 'package:flutter/material.dart';
import 'package:sopefoodrestaurantes/common/custom_appbar.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';
import 'package:sopefoodrestaurantes/views/home/restaurant_orders/self_deliveries.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/back_ground_container.dart';

class SelfDeliveredPage extends StatelessWidget {
  const SelfDeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Ver todas las entregas internas y los ingresos por entregas",
          heading: "Bienvenido a SopeFood",
        ),
        elevation: 0,
        backgroundColor: kLightWhite,
      ),
      body: const BackGroundContainer(child: SelfDeliveries()),
    );
  }
}
