import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sopefoodrestaurantes/common/shimmers/foodlist_shimmer.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';
import 'package:sopefoodrestaurantes/controllers/updates_controllers/ready_for_pick_up_controller.dart';
import 'package:sopefoodrestaurantes/hooks/fetchRestaurantOrders.dart';
import 'package:sopefoodrestaurantes/models/ready_orders.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/empty_page.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/order_tile.dart';
import 'package:get/get.dart';

class ReadyForDelivery extends HookWidget {
  const ReadyForDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadyForPickUpController());
    final hookResult = useFetchPicked("ready");
    List<ReadyOrders>? orders = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;

    controller.setOnStatusChangeCallback(refetch);

    if (isLoading) {
      return const FoodsListShimmer();
    } else if (orders!.isEmpty) {
      return const EmptyPage();
    }

    return Container(
      height: hieght / 1.3,
      width: width,
      color: Colors.transparent,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w),
          itemCount: orders.length,
          itemBuilder: (context, i) {
            ReadyOrders order = orders[i];
            return OrderTile(
              order: order,
              active: 'ready',
            );
          }),
    );
  }
}
