import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sopefoodrestaurantes/common/shimmers/foodlist_shimmer.dart';
import 'package:sopefoodrestaurantes/hooks/fetchFoods.dart';
import 'package:sopefoodrestaurantes/models/foods.dart';
import 'package:sopefoodrestaurantes/views/food/food_page.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/empty_page.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/food_tile.dart';
import 'package:get/get.dart';

class FoodList extends HookWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchFood();
    final foods = hookResult.data;
    final isLoading = hookResult.isLoading;

    if (isLoading) {
      return const FoodsListShimmer();
    } else if (foods!.isEmpty) {
      return const EmptyPage();
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
        right: 8,
      ),
      height: 210.h,
      child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            Food food = foods[index];
            return CategoryFoodTile(
                onTap: () {
                  Get.to(() => FoodPage(food: food),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 500));
                },
                food: food);
          }),
    );
  }
}
