import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sopefoodrestaurantes/common/app_style.dart';
import 'package:sopefoodrestaurantes/common/custom_appbar.dart';
import 'package:sopefoodrestaurantes/common/reusable_text.dart';
import 'package:sopefoodrestaurantes/common/tab_widget.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';
import 'package:sopefoodrestaurantes/controllers/order_controller.dart';
import 'package:sopefoodrestaurantes/controllers/restaurant_controller.dart';
import 'package:sopefoodrestaurantes/views/home/add_foods.dart';
import 'package:sopefoodrestaurantes/views/home/foods_page.dart';
import 'package:sopefoodrestaurantes/views/home/restaurant_orders/cancelled_orders.dart';
import 'package:sopefoodrestaurantes/views/home/restaurant_orders/picked_orders.dart';
import 'package:sopefoodrestaurantes/views/home/restaurant_orders/preparing.dart';
import 'package:sopefoodrestaurantes/views/home/restaurant_orders/delivered.dart';
import 'package:sopefoodrestaurantes/views/home/restaurant_orders/new_orders.dart';
import 'package:sopefoodrestaurantes/views/home/restaurant_orders/ready_for_pick_up.dart';
import 'package:sopefoodrestaurantes/views/home/restaurant_orders/self_deliveries.dart';
import 'package:sopefoodrestaurantes/views/home/self_delivered_page.dart';
import 'package:sopefoodrestaurantes/views/home/wallet_page.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/back_ground_container.dart';
import 'package:get/get.dart';

class HomePage extends StatefulHookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 7,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    final restaurantController = Get.put(RestaurantController());
    final orderController = Get.put(OrdersController());
    _tabController.animateTo(orderController.tabIndex);
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CustomAppBar(
            type: true,
            onTap: () {
              restaurantController.restaurantStatus();
            },
          ),
          elevation: 11,
          backgroundColor: kLightWhite,
        ),
        body: BackGroundContainer(
          child: SizedBox(
            height: hieght,
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 66.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          HomeTile(
                            imagePath: "assets/icons/taco.svg",
                            text: "Agregar Comida",
                            onTap: () {
                              Get.to(() => const AddFoodsPage(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 400));
                            },
                          ),
                          const Positioned(
                              left: 15,
                              child: Icon(
                                AntDesign.pluscircle,
                                color: Colors.green,
                              ))
                        ],
                      ),
                      HomeTile(
                        imagePath: "assets/icons/wallet.svg",
                        text: "Billetera",
                        onTap: () {
                          Get.to(() => const WalletPage(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400));
                        },
                      ),
                      HomeTile(
                        imagePath: "assets/icons/french_fries.svg",
                        text: "Comidas",
                        onTap: () {
                          Get.to(() => const FoodsPage(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400));
                        },
                      ),
                      HomeTile(
                        imagePath: "assets/icons/deliver_food.svg",
                        text: "Auto Entrega",
                        onTap: () {
                          Get.to(() => const SelfDeliveredPage(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Container(
                    height: 25.h,
                    width: width,
                    decoration: BoxDecoration(
                      color: kOffWhite,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      labelPadding: EdgeInsets.zero,
                      labelColor: Colors.white,
                      dividerColor: Colors.transparent,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      labelStyle: appStyle(12, kLightWhite, FontWeight.normal),
                      unselectedLabelColor: Colors.grey.withOpacity(0.7),
                      tabs: const <Widget>[
                        Tab(
                          child: TabWidget(text: "Nuevas Ordenes"),
                        ),
                        Tab(
                          child: TabWidget(text: "Preparando"),
                        ),
                        Tab(
                          child: TabWidget(text: "Listas"),
                        ),
                        Tab(
                          child: TabWidget(text: "Escogido"),
                        ),
                        Tab(
                          child: TabWidget(text: "Autoentregas"),
                        ),
                        Tab(
                          child: TabWidget(text: "Entregado"),
                        ),
                        Tab(
                          child: TabWidget(text: "Cancelados"),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: hieght * 0.7,
                  child:
                      TabBarView(controller: _tabController, children: const [
                    NewOrders(),
                    PreparingOrders(),
                    ReadyForDelivery(),
                    PickedOrders(),
                    SelfDeliveries(),
                    DeliveredOrders(),
                    CancelledOrders()
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTile extends StatelessWidget {
  const HomeTile({
    super.key,
    required this.imagePath,
    required this.text,
    this.onTap,
  });

  final String imagePath;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            imagePath,
            width: 44.w,
            height: 44.h,
          ),
          ReusableText(text: text, style: appStyle(12, kGray, FontWeight.w600))
        ],
      ),
    );
  }
}
