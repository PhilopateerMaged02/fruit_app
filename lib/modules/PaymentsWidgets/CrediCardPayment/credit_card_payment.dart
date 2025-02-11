import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/PaymentsWidgets/NonSuccessPayment/non_success_payment.dart';
import 'package:fruit_app/modules/PaymentsWidgets/SuccessPayment/success_payment.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditCardPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(ApiContest.visaUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(ApiContest.visaUrl));
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Pay with Credit Card'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                FruitAppCubit.get(context).getTransactionDetails();
                if (state is FruitAppGetTransactionDetailsLoading) {
                } else if (state is FruitAppGetTransactionDetailsSuccess) {
                  var price = FruitAppCubit.get(context).finalPrice + 30;
                  navigateTo(context, SuccessPayment());
                  FruitAppCubit.get(context).cartItems.clear();
                  print("length of cart is : " +
                      FruitAppCubit.get(context).cartItems.length.toString());
                  FruitAppCubit.get(context).removeCart();
                  print("length of stream cart is : " +
                      FruitAppCubit.get(context).streamList.length.toString());
                  FruitAppCubit.get(context).creatOrder(
                      name: FruitAppCubit.get(context).userModel!.name,
                      price: price.toString(),
                      email: FruitAppCubit.get(context).userModel!.email,
                      address: FruitAppCubit.get(context).address,
                      city: FruitAppCubit.get(context).city,
                      floorApart: FruitAppCubit.get(context).floorApart,
                      quantity: FruitAppCubit.get(context).cartItems.length + 1,
                      payment_method: FruitAppCubit.get(context).visa!
                          ? "visa"
                          : "masterCard",
                      status: "تم قبول الطلب",
                      date: DateTime.now().toString().split(' ')[0]);
                } else if (state is FruitAppGetTransactionDetailsError) {
                  navigateTo(context, NonSuccessPayment());
                }
              },
            ),
          ),
          body: WebViewWidget(controller: controller),
        );
      },
    );
  }
}
