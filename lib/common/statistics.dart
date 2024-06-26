import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sopefoodrestaurantes/common/app_style.dart';
import 'package:sopefoodrestaurantes/common/reusable_text.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';

class Statistics extends StatelessWidget {
  const Statistics({
    super.key,
    required this.ordersTotal,
    required this.cancelledOrders,
    required this.processingOrders,
    required this.revenueTotal,
  });

  final int ordersTotal;
  final int cancelledOrders;
  final int processingOrders;
  final double revenueTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.h),
      decoration: const BoxDecoration(
        color: kWhite,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: ordersTotal.toString(),
                        style: appStyle(15, kGray, FontWeight.w600)),
                    ReusableText(
                        text: "Ordenes Totales",
                        style: appStyle(11, kGray, FontWeight.normal)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: processingOrders.toString(),
                        style: appStyle(15, kGray, FontWeight.w600)),
                    ReusableText(
                        text: "En Proceso",
                        style: appStyle(11, kGray, FontWeight.normal)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: cancelledOrders.toString(),
                        style: appStyle(15, kGray, FontWeight.w600)),
                    ReusableText(
                        text: "Canceladas",
                        style: appStyle(11, kGray, FontWeight.normal)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: "\$${revenueTotal.toStringAsFixed(2).toString()}",
                        style: appStyle(15, kGray, FontWeight.w600)),
                    ReusableText(
                        text: "Ganancia",
                        style: appStyle(11, kGray, FontWeight.normal)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: 0.toString(),
                        style: appStyle(15, kGray, FontWeight.w600)),
                    ReusableText(
                        text: "Entregas totales",
                        style: appStyle(11, kGray, FontWeight.normal)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: 0.toString(),
                        style: appStyle(14, kGray, FontWeight.w600)),
                    ReusableText(
                        text: "Ingresos entrega",
                        style: appStyle(11, kGray, FontWeight.normal)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text: "\$${(revenueTotal * 0.1).toStringAsFixed(2)}",
                        style: appStyle(14, kGray, FontWeight.w600)),
                    ReusableText(
                        text: "Comision ",
                        style: appStyle(11, kGray, FontWeight.normal)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                        text:
                            "\$${(revenueTotal - revenueTotal * 0.1).toStringAsFixed(2).toString()}",
                        style: appStyle(15, kGray, FontWeight.w600)),
                    ReusableText(
                        text: "Retirable",
                        style: appStyle(11, kGray, FontWeight.normal)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
