import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/Service/DioHelper.dart';
import 'package:fruit_app/main.dart';
import 'package:fruit_app/models/CartModel/cart_model.dart';
import 'package:fruit_app/models/ProductsModel/products_model.dart';
import 'package:fruit_app/models/ReviewsModel/reviews_model.dart';
import 'package:fruit_app/models/UserModel/user_model.dart';
import 'package:fruit_app/modules/Cart/cart.dart';
import 'package:fruit_app/modules/Home/home.dart';
import 'package:fruit_app/modules/Login/login_screen.dart';
import 'package:fruit_app/modules/MyAccount/myaccount.dart';
import 'package:fruit_app/modules/Products/products.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FruitAppCubit extends Cubit<FruitAppStates> {
  FruitAppCubit() : super(FruitAppInitialStates());
  static FruitAppCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  ProductsModel? productsModel;
  CartModel? cartModel;
  ReviewsModel? reviewsModel;
  bool fruitItemIsClicked = false;
  int currentIndex = 0;
  String refrenceCode = '';
  String address = "";
  String city = "";
  String floorApart = "";
  bool isPaymentSuccess = false;
  List<Widget> Screens = [Home(), Products(), Cart(), MyAccount()];
  // List<String> Titles = [
  //   "Home",
  //   "Products",
  //   "Cart",
  //   "MyAccount",
  // ];
  bool? x = true, y, w, z;
  bool? pay1 = false;
  bool? pay2 = false;
  // bool? address = false;
  // bool? payment = false;
  // bool? review = false;
  bool? saveAddress = false;
  bool? creditCard = false;
  bool? visa = false;
  bool? mastercard = false;
  bool? paypal = false;
  bool? applepay = false;
  bool radio1 = false, radio2 = false, radio3 = false;
  bool star1 = false,
      star2 = false,
      star3 = false,
      star4 = false,
      star5 = false;
  void changeRadio1() {
    radio1 = true;
    radio2 = false;
    radio3 = false;
    emit(FruitAppChangeRadioState());
  }

  void changeRadio2() {
    radio1 = false;
    radio2 = true;
    radio3 = false;
    emit(FruitAppChangeRadioState());
  }

  void changeRadio3() {
    radio1 = false;
    radio2 = false;
    radio3 = true;
    emit(FruitAppChangeRadioState());
  }

  void changeRadioPay1() {
    pay1 = true;
    pay2 = false;
    emit(FruitAppChangeRadioState());
  }

  void changeRadioPay2() {
    pay1 = false;
    pay2 = true;
    emit(FruitAppChangeRadioState());
  }

  void changeSaveAddress() {
    saveAddress = !saveAddress!;
    emit(FruitAppChangeSwitchState());
  }

  void changeCheckBox() {
    creditCard = !creditCard!;
    emit(FruitAppChangeCheckBoxState());
  }

  void changePaymentMethodToVisa() {
    visa = true;
    mastercard = false;
    paypal = false;
    applepay = false;
    emit(FruitAppChangePaymentMethodState());
  }

  void changePaymentMethodToMastercard() {
    visa = false;
    mastercard = true;
    paypal = false;
    applepay = false;
    emit(FruitAppChangePaymentMethodState());
  }

  void changePaymentMethodToPaypal() {
    visa = false;
    mastercard = false;
    paypal = true;
    applepay = false;
    emit(FruitAppChangePaymentMethodState());
  }

  void changePaymentMethodToApplepay() {
    visa = false;
    mastercard = false;
    paypal = false;
    applepay = true;
    emit(FruitAppChangePaymentMethodState());
  }

  // void changeRadioAddress() {
  //   address = true;
  //   emit(FruitAppChangeRadioState());
  // }

  // void changeRadioPayment() {
  //   payment = true;
  //   emit(FruitAppChangeRadioState());
  // }

  // void changeRadioReview() {
  //   review = true;
  //   emit(FruitAppChangeRadioState());
  // }

  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      x = true;
      y = false;
      w = false;
      z = false;
    } else if (currentIndex == 1) {
      y = true;
      x = false;
      w = false;
      z = false;
    } else if (currentIndex == 2) {
      w = true;
      x = false;
      y = false;
      z = false;
      getCartItems();
      print(cartItems.length);
    } else if (currentIndex == 3) {
      z = true;
      x = false;
      y = false;
      w = false;
    }
    emit(FruitAppChangeBottomNavStates());
  }

  void getUserData() async {
    emit(FruitAppGetUserDataLoading());
    final response = await supabase.auth.getUser();
    final user = response.user;

    if (user != null) {
      emit(FruitAppGetUserDataSuccess());
      final userMetadata = user.userMetadata;
      userModel = UserModel(
        uId: user.id,
        email: user.email!,
        name: userMetadata?['Display name'] ?? '',
        phone: userMetadata?['Phone'] ?? '',
        profile_image: userMetadata?['profile_image'] ?? '',
      );
      print('Email: ${user.email}');
      print('Name: ${userModel!.name}');
      print('Phone: ${userModel!.phone}');
      print('Profile_IMAGE: ${userModel!.profile_image}');
    } else {
      emit(FruitAppGetUserDataError());
      print('No user is logged in');
    }
  }

  List<ProductsModel> productsList = [];

  void getProductsData() async {
    try {
      emit(FruitAppGetProductsDataLoading());

      // Fetch products from the Supabase table
      final response = await supabase.from('products').select();

      // Cast the response to a List of dynamic maps
      final List<dynamic> products = response as List<dynamic>;

      if (products.isNotEmpty) {
        //productsList.clear();

        for (final product in products) {
          final productModel = ProductsModel(
            id: product['id'] ?? 0,
            name: product['name'] ?? '',
            price: _parsePrice(product['price']),
            image: product['image'] ?? '',
            quantity: product['quantity'] ?? 0,
          );
          productsList.add(productModel);
        }

        emit(FruitAppGetProductsDataSuccess());
        print('Fetched ${productsList.length} products.');
      } else {
        emit(FruitAppGetProductsDataError());
        print('No products found in the database.');
      }
    } catch (e) {
      emit(FruitAppGetProductsDataError());
      print('Error fetching products: $e');
    }
  }

// Helper method to parse the price field
  double _parsePrice(dynamic price) {
    if (price == null) {
      return 0.0; // Default to 0.0 if price is null
    } else if (price is int) {
      return price.toDouble(); // Convert int to double
    } else if (price is double) {
      return price; // Already a double
    } else if (price is String) {
      return double.tryParse(price) ?? 0.0; // Parse string to double
    } else {
      print('Unexpected price type: ${price.runtimeType}');
      return 0.0; // Fallback to 0.0 for unexpected types
    }
  }

  ////////////////////////////////////////////////////
  Future<void> sendOtp(String emailOrPhone) async {
    try {
      await supabase.auth.signInWithOtp(
        email: emailOrPhone, // Replace with phone number if needed
        emailRedirectTo:
            'com.example.app://reset-callback', // Use a custom URL for email-based resets
      );
      print('OTP sent successfully.');
    } catch (error) {
      print('Error sending OTP: $error');
    }
  }

  Future<void> sendOtpToPhone(String phoneNumber) async {
    try {
      await Supabase.instance.client.auth.signInWithOtp(
        phone: phoneNumber,
      );
      print('OTP sent to $phoneNumber');
    } catch (error) {
      print('Error sending OTP: $error');
    }
  }

  void signOutt(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      await supabase.removeAllChannels();
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('uId');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MyApp(
                  startWidget: LoginScreen(),
                )),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Error signing out: $error');
    }
  }

////////////////////////////////////////////////////////////

  List<CartModel> cartItems = [];

  Stream<List<Map<String, dynamic>>> get streamList {
    return supabase
        .from('cart')
        .stream(primaryKey: ['id'])
        .eq('uId', uId!)
        .map((data) {
          print("Stream data updated: $data");
          return data;
        });
  }

  void removeCart() async {
    await supabase.from('cart').delete().eq('uId', uId!);
  }

  void getCartItems() async {
    try {
      //emit(FruitAppGetCartDataLoading());
      final response =
          await supabase.from('cart').select('*, products(*)').eq('uId', uId!);

      final List<dynamic> cart = response as List<dynamic>;

      if (cart.isNotEmpty) {
        cartItems.clear();

        for (final product in cart) {
          final cartModel = CartModel(
            id: product['id'] ?? 0,
            name: product['name'] ?? '',
            image: product['image'] ?? '',
            price: _parsePrice(product['price']),
            quantity: product['quantity'] ?? 0,
            product_id: product['product_id'] ?? 0,
          );
          cartItems.add(cartModel);
        }
        //emit(FruitAppGetCartDataSuccess());
        finalPrice = 0.0;
        cartItems.forEach((element) {
          print("Quantity: ${element.quantity}");
          print("Price: ${element.price}");
          finalPrice += element.price * element.quantity;
        });
        print('Fetched ${cartItems} products.');
        print('Fetched ${cartItems.length} products.');
      } else {
        //emit(FruitAppGetCartDataError());
        print('No products found in the cart.');
      }
    } catch (e) {
      //emit(FruitAppGetCartDataError());
      print('Error fetching products: $e');
    }
  }

  double finalPrice = 0.0;
  Future<void> removeFromCart(
      int cartItemId, int quantity, int productId) async {
    emit(FruitAppRemoveFromCartLoading());
    final response = await supabase
        .from('products')
        .select('quantity')
        .eq('id', productId)
        .maybeSingle();

    if (response != null) {
      // Update product quantity in the 'products' table
      await supabase.from('products').update({
        "quantity": response['quantity'] + quantity,
      }).eq("id", productId);
      await supabase.from('cart').delete().eq('id', cartItemId);

      emit(FruitAppRemoveFromCartSuccess());
    } else {
      emit(FruitAppRemoveFromCartError());
    }
  }

  void addtocart(int productId, int quantity, String name, String image,
      double price) async {
    emit(FruitAppAddToCartLoading());
    try {
      // Step 1: Insert into the cart table

      // Step 2: Retrieve the current quantity from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .single();

      if (response != null &&
          response['quantity'] >= quantity &&
          response['quantity'] > 0) {
        // Step 3: Decrement the quantity in the products table
        await supabase.from('products').update({
          "quantity": response['quantity'] - quantity,
        }).eq('id', productId);
        await supabase.from('cart').insert({
          "product_id": productId,
          "uId": uId,
          "quantity": quantity,
          "name": name,
          "image": image,
          "price": price
        });
        print('Fetched ${cartItems} products.');
        print('Fetched ${cartItems.length} products.');
        emit(FruitAppAddToCartSuccess());
        getCartItems();
      } else {
        emit(FruitAppAddToCartError());
        print("Error: Insufficient quantity available.");
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      emit(FruitAppAddToCartError());
    }
  }

  void increaseItemInCart(int productId, int quantity, String name,
      String image, double price, int CartId) async {
    //emit(FruitAppAddToCartLoading());
    try {
      // Fetch the product from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .maybeSingle(); // Use maybeSingle() to avoid errors when no rows are returned

      if (response == null) {
        //emit(FruitAppAddToCartError());
        print("Error: Product not found.");
        return;
      }

      // Log the actual quantity from the database and requested quantity
      print("Database Quantity: ${response['quantity']}");
      print("Requested Quantity: $quantity");

      // Ensure there is enough quantity in stock
      if (response['quantity'] >= quantity &&
          response['quantity'] > 0 &&
          quantity > 0) {
        // Update the product quantity
        await supabase.from('products').update({
          "quantity": response['quantity'] - 1,
        }).eq('id', productId);

        // Update the cart quantity
        await supabase.from('cart').update({
          "quantity": quantity + 1,
        }).eq("id", CartId);
        finalPrice += price;
        print(finalPrice);
        //emit(FruitAppAddToCartSuccess());
        //getCartItems();
      } else {
        //emit(FruitAppAddToCartError());
        print("Error: Insufficient quantity available.");
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      //emit(FruitAppAddToCartError());
    }
  }

  void decreaseItemInCart(int productId, int quantity, String name,
      String image, double price, int CartId) async {
    //emit(FruitAppRemoveFromCartLoading());
    try {
      // Fetch the product from the products table
      final response = await supabase
          .from('products')
          .select('quantity')
          .eq('id', productId)
          .maybeSingle();

      if (response == null) {
        //emit(FruitAppRemoveFromCartError());
        print("Error: Product not found.");
        return;
      }

      print("Database Quantity: ${response['quantity']}");
      print("Requested Quantity: $quantity");

      if (quantity >= 1) {
        await supabase.from('products').update({
          "quantity": response['quantity'] + 1,
        }).eq('id', productId);

        await supabase.from('cart').update({
          "quantity": quantity - 1,
        }).eq("id", CartId);
        finalPrice -= price;
        print(finalPrice);
        //emit(FruitAppRemoveFromCartSuccess());
        //getCartItems();
        print(cartItems.length);
      } else if (quantity <= 0) {
        await supabase.from('cart').delete().eq("id", CartId);
        finalPrice -= price;
        print(finalPrice);
        getCartItems();
        //emit(FruitAppRemoveFromCartSuccess());
      } else {
        //emit(FruitAppRemoveFromCartError());
        print("Error: Insufficient quantity available.");
        //getCartItems();
      }
    } catch (error) {
      print("Error in adding to cart: $error");
      //emit(FruitAppRemoveFromCartError());
    }
  }

  void changeFruitItemIcon(CartModel cart, productId) {
    if (cart.product_id == productId) {
      fruitItemIsClicked = !fruitItemIsClicked;
    }
    emit(FruitAppChangeFruitItemState());
  }

  void createReview({
    required String name,
    required String image,
    required String time,
    required String comment,
    required int rate,
    required int product_id,
  }) async {
    emit(FruitAppCreateReviewLoading());
    supabase.from('reviews').insert({
      "uId": uId,
      "name": name,
      "image": image,
      "product_id": product_id,
      "rate": rate,
      "comment": comment,
      "time": time,
    }).then((value) {
      emit(FruitAppCreateReviewSuccess());
    }).catchError((error) {
      emit(FruitAppCreateReviewError());
      print(error.toString());
    });
  }

  List<ReviewsModel> reviewsList = [];

  void getReviewsData({
    required int product_id,
  }) async {
    try {
      emit(FruitAppGetReviewsDataLoading());

      reviewsList.clear();
      final response =
          await supabase.from('reviews').select().eq("product_id", product_id);

      // Cast the response to a List of dynamic maps
      final List<dynamic> reviews = response as List<dynamic>;

      if (reviews.isNotEmpty) {
        //productsList.clear();

        for (final review in reviews) {
          final reviewModel = ReviewsModel(
            id: review['id'] ?? 0,
            name: review['name'] ?? '',
            image: review['image'] ?? '',
            comment: review['comment'] ?? '',
            product_id: review['product_id'] ?? 0,
            rate: review['rate'] ?? 0,
            time: review['time'] ?? '',
            uId: review['uId'] ?? '',
          );
          reviewsList.add(reviewModel);
        }

        emit(FruitAppGetReviewsDataSuccess());
        print('Fetched ${reviewsList.length} products.');
      } else {
        emit(FruitAppGetReviewsDataError());
        print('No products found in the database.');
      }
    } catch (e) {
      emit(FruitAppGetReviewsDataError());
      print('Error fetching products: $e');
    }
  }

  Future<void> getAuthToken() async {
    emit(FruitAppGetAuthTokenLoading());
    Diohelper.postDataDio(url: ApiContest.getAuthToken, data: {
      "api_key": ApiContest.paymentApiKey,
    }).then((value) {
      ApiContest.paymentFirstToken = value.data['token'];
      print("the token is : " + ApiContest.paymentFirstToken);
      emit(FruitAppGetAuthTokenSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FruitAppGetAuthTokenError());
    });
  }

  Future<void> getOrderRegisterationId({
    required String firstName,
    required String email,
    required String price,
  }) async {
    emit(FruitAppGetOrderRegisterationIdLoading());
    Diohelper.postDataDio(url: ApiContest.getOrderId, data: {
      "auth_token": ApiContest.paymentFirstToken,
      "amount_cents": price,
    }).then((value) {
      ApiContest.paymentOrderId = value.data['id'].toString();
      print("the payment order id token is : " + ApiContest.paymentOrderId);
      getPaymentRequest(firstName: firstName, email: email, price: price);
      emit(FruitAppGetOrderRegisterationIdSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FruitAppGetOrderRegisterationIdError());
    });
  }

  Future<void> getPaymentRequest({
    required String firstName,
    required String email,
    required String price,
  }) async {
    emit(FruitAppGetPaymentRequestLoading());
    Diohelper.postDataDio(url: ApiContest.getPaymentId, data: {
      "auth_token": ApiContest.paymentFirstToken,
      "amount_cents": price,
      "expiration": "3600",
      "order_id": ApiContest.paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "first_name": firstName,
        "last_name": "NA",
        "street": "NA",
        "building": "NA",
        "phone_number": "NA",
        "city": "NA",
        "country": "NA",
        "email": email,
        "floor": "NA",
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": ApiContest.integrationIdCard,
      "lock_order_when_paid": "false"
    }).then((value) {
      ApiContest.finalToken = value.data['token'];
      print("the final token is : " + ApiContest.finalToken);
      ApiContest.visaUrl = "";
      ApiContest.visaUrl =
          "${ApiContest.baseUrl}/acceptance/iframes/896181?payment_token=${value.data['token']}";
      print(ApiContest.visaUrl);
      emit(FruitAppGetPaymentRequestSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FruitAppGetPaymentRequestError());
    });
  }

  Future<void> getRefCode() async {
    emit(FruitAppGetRefCodeLoading());
    Diohelper.postDataDio(url: ApiContest.getRefCode, data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": ApiContest.finalToken
    }).then((value) {
      ApiContest.refCode = value.data['id'].toString();
      refrenceCode = ApiContest.refCode;
      print("the ref num is : " + ApiContest.refCode);
      emit(FruitAppGetRefCodeSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(FruitAppGetRefCodeError());
    });
  }

  Future<void> getTransactionDetails() async {
    emit(FruitAppGetTransactionDetailsLoading());
    final response = await Diohelper.getDataDio(url: ApiContest.transactionUrl);

    if (response.statusCode == 200) {
      print(response.data['results']);
      if (response.data['results'] != null &&
          response.data['results'].isNotEmpty) {
        var success = response.data['results'][0]['success'];
        isPaymentSuccess = success;
        if (success) {
          print("Payment was approved!");
          emit(FruitAppGetTransactionDetailsSuccess());
        } else {
          print("Payment was not approved.");
          emit(FruitAppGetTransactionDetailsError());
        }
      } else {
        print("No transaction data found.");
        emit(FruitAppGetTransactionDetailsError());
      }
    }
  }

  void creatOrder({
    required String name,
    required String price,
    required String email,
    required String address,
    required String city,
    required String floorApart,
    required int quantity,
    required String payment_method,
    required String status,
    required String date,
  }) async {
    emit(FruitAppCreateOrderLoading());
    await supabase.from('orders').insert({
      "name": name,
      "price": price,
      "email": email,
      "address": address,
      "city": city,
      "uId": uId,
      "floorApart": floorApart,
      "quantity": quantity,
      "payment_method": payment_method,
      "status": status,
      "date": date,
    }).then((value) {
      emit(FruitAppCreateOrderSuccess());
    }).catchError((error) {
      emit(FruitAppCreateOrderError());
    });
  }
}
