import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sopefoodrestaurantes/common/app_style.dart';
import 'package:sopefoodrestaurantes/common/custom_appbar.dart';
import 'package:sopefoodrestaurantes/common/custom_btn.dart';
import 'package:sopefoodrestaurantes/common/reusable_text.dart';
import 'package:sopefoodrestaurantes/common/shimmers/foodlist_shimmer.dart';
import 'package:sopefoodrestaurantes/common/statistics.dart';
import 'package:sopefoodrestaurantes/constants/constants.dart';
import 'package:sopefoodrestaurantes/controllers/login_controller.dart';
import 'package:sopefoodrestaurantes/controllers/payout_controller.dart';
import 'package:sopefoodrestaurantes/hooks/fetch_restaurant.dart';
import 'package:sopefoodrestaurantes/models/payout_request.dart';
import 'package:sopefoodrestaurantes/models/restaurant_response.dart';
import 'package:sopefoodrestaurantes/views/auth/widgets/email_textfield.dart';
import 'package:sopefoodrestaurantes/views/home/widgets/back_ground_container.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WalletPage extends StatefulHookWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final box = GetStorage();
  final TextEditingController bank = TextEditingController();
  final TextEditingController account = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final payoutController = Get.put(PayoutCotroller());
    String id = box.read('restaurantId');
    RestaurantResponse? restaurant = controller.getRestuarantData(id);

    final data = fetchRestaurant(id);
    final ordersTotal = data.ordersTotal;
    final cancelledOrders = data.cancelledOrders;
    final processingOrders = data.processingOrders;
    final payout = data.payout;
    final revenueTotal = data.revenueTotal;
    final isLoading = data.isLoading;
    final error = data.error;
    final refetch = data.refetch;

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: CustomAppBar(
            title: "Vea todas sus ganancias por pedidos completados y entregas",
            heading: "Bienvenido a SopeFood",
          ),
          elevation: 0,
          backgroundColor: kLightWhite,
        ),
        body: const BackGroundContainer(
            color: kLightWhite, child: FoodsListShimmer()),
      );
    }

    return Scaffold(
      backgroundColor: kLightWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Vea todas sus ganancias por pedidos completados y entregas",
          heading: "Bienvenido a SopeFood",
        ),
        elevation: 50,
        backgroundColor: kLightWhite,
      ),
      body: BackGroundContainer(
          color: kWhite,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(
                                text: restaurant!.title,
                                style: appStyle(19, kGray, FontWeight.w600)),
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: kGray,
                              backgroundImage: NetworkImage(restaurant.logoUrl),
                            ),
                          ]),
                    ),
                    const Divider(),
                    Statistics(
                      ordersTotal: ordersTotal,
                      cancelledOrders: cancelledOrders,
                      processingOrders: processingOrders,
                      revenueTotal: revenueTotal,
                    ),
                    const Divider(),
                    payout.isEmpty
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              RowText(
                                first: "Latest Request",
                                second: payout[0]
                                    .createdAt
                                    .toString()
                                    .substring(0, 10),
                                bold: true,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              RowText(
                                first: payout[0].id,
                                second:
                                    "\$ ${payout[0].amount.toStringAsFixed(2)}",
                                bold: false,
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomButton(
                      radius: 0,
                      btnWidth: width,
                      text: "Solicitud de Pago",
                      onTap: () {
                        controller.setRequest = !controller.payout;
                      },
                      color: kSecondary,
                    ),
                    Obx(
                      () => controller.payout
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                EmailTextField(
                                  controller: bank,
                                  hintText: "Nombre de Banco",
                                  prefixIcon: Icon(
                                    AntDesign.bank,
                                    color: Theme.of(context).dividerColor,
                                    size: 20.h,
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                EmailTextField(
                                  controller: name,
                                  hintText: "Nombre Usuario",
                                  prefixIcon: Icon(
                                    AntDesign.user,
                                    color: Theme.of(context).dividerColor,
                                    size: 20.h,
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                EmailTextField(
                                  controller: account,
                                  hintText: "Numero de Cuenta",
                                  prefixIcon: Icon(
                                    AntDesign.calculator,
                                    color: Theme.of(context).dividerColor,
                                    size: 20.h,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                EmailTextField(
                                  controller: amount,
                                  hintText: "Cantidad",
                                  prefixIcon: Icon(
                                    AntDesign.pay_circle_o1,
                                    color: Theme.of(context).dividerColor,
                                    size: 20.h,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomButton(
                                  text: "Enviar Pago",
                                  color: kPrimary,
                                  radius: 0,
                                  onTap: () {
                                    PayoutRequest payout = PayoutRequest(
                                        restaurant: id,
                                        amount: amount.text,
                                        accountNumber: account.text,
                                        accountName: name.text,
                                        accountBank: bank.text,
                                        method: "bank_transfer");

                                    String data = payoutRequestToJson(payout);

                                    double amountDouble =
                                        double.parse(amount.text);

                                    if (amountDouble >
                                        (revenueTotal - revenueTotal * 0.1)) {
                                      // insufficient amount
                                      insufficientFunds(context);
                                    } else {
                                      payoutController.payout(data, refetch);
                                      controller.setRequest =
                                          !controller.payout;
                                      amount.text = '';
                                      name.text = '';
                                      bank.text = '';
                                      account.text = '';
                                    }
                                  },
                                )
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

Future<dynamic> insufficientFunds(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
      title: ReusableText(
          text: 'Retiro denegado', style: appStyle(15, kDark, FontWeight.bold)),
      contentPadding: const EdgeInsets.all(20.0),
      content: Text(
          'Lamentamos informarle que su solicitud de retiro no se puede procesar en este momento debido a que el saldo de la cuenta es insuficiente. Para garantizar un proceso de transacción sin problemas, le solicitamos que revise su saldo actual e intente realizar el retiro una vez que haya fondos suficientes disponibles. Apreciamos mucho su comprensión y cooperación, y estamos aquí para ayudarlo con cualquier consulta o soporte adicional que pueda necesitar con respecto a su cuenta o este asunto.',
          textAlign: TextAlign.justify,
          style: appStyle(11, kDark, FontWeight.normal)),
    ),
  );
}

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.first,
    required this.second,
    required this.bold,
  });

  final String first;
  final String second;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      ReusableText(
          text: first,
          style: appStyle(11, bold ? kGray : kGrayLight,
              bold ? FontWeight.bold : FontWeight.normal)),
      ReusableText(
          text: second,
          style:
              appStyle(11, kGray, bold ? FontWeight.bold : FontWeight.normal)),
    ]);
  }
}
