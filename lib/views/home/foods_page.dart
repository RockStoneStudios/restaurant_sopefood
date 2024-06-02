import 'package:flutter/material.dart';
import 'package:sopefoodrestaurantes/common/custom_appbar.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/back_ground_container.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/food_list.dart';

class FoodsPage extends StatelessWidget {
  const FoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Vea todos los alimentos en su restaurante y edítelos ",
          heading: "Bienvenido a SopeFood",
        ),
        elevation: 0,
        backgroundColor: kLightWhite,
      ),
      body: const BackGroundContainer(
        child: FoodList(),
      ),
    );
  }
}
